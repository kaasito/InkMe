//
//  SubirViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 24/2/22.
//

import UIKit
import Alamofire
import AlamofireImage


class SubirViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData!.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        <#code#>
    }
    
    @IBOutlet weak var picker: UIPickerView!
    var imageURL: URL?
    var pickerData:[String]?
    let defaults = UserDefaults.standard
    var token = ""
    @IBOutlet weak var imagenSeleccionada: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        token = defaults.string(forKey: "token")!
        print(token)
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["BlackWork", "Neotradicional", "Tradicional", "Tradicional Japonés", "Realista"]
    }
    
   
    @IBAction func enviarBoton(_ sender: Any) {
        let url = "http://desarrolladorapp.com/inkme/public/api/subirImagen"
       // let urrl = URL(string: url)
       // let image = imagenSeleccionada.image
       // let imageData = image!.pngData() //el data
       
        AF.upload(multipartFormData: { multipartformdata in
            multipartformdata.append(self.imageURL!, withName: "imagen")
        }, to: url, method: .post).responseDecodable(of: ResponseSubir.self){ response in
            let url = response.value?.url
            
            let urlpeticion = "http://desarrolladorapp.com/inkme/public/api/crearPost"
            let json = ["api_token": self.token, "description": "hola", "photo": url!, "title": "nueva foto", "style": "blackwork", "bcolor": 1] as [String : Any]
            AF.request(urlpeticion, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseSubirPost.self) { response in
                if response.value?.status == 1{
                    let alert = UIAlertController(title: "Foto publicada con éxito!", message: "La foto se ha subido exitosamente", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: { action in
                        switch action.style{
                            case .default:
                            print("default")
                            
                            case .cancel:
                            print("cancel")
                            
                            case .destructive:
                            print("destructive")
                            
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Ha habido un error", message: "No se ha podido subir la foto, revisa tu conexión.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Vale", style: .destructive, handler: { action in
                        switch action.style{
                            case .default:
                            print("default")
                            
                            case .cancel:
                            print("cancel")
                            
                            case .destructive:
                            print("destructive")
                            
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
               
            }
        }
        
                
      
    }
    @IBAction func botonCamara(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func botonGaleria(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
}



struct ResponseSubir:Decodable{
    let status: Int?
    let url: String?
}

struct ResponseSubirPost:Decodable {
    let status: Int?
    let msg: String?
    let post_id: Int?
}

