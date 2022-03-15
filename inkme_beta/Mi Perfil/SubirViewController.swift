//
//  SubirViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 24/2/22.
//

import UIKit
import Alamofire
import AlamofireImage


class SubirViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate{
    @IBOutlet weak var textoSeleccion: UILabel!
    @IBOutlet weak var tituloField: UITextField!
    var imageURL: URL?
    var pickerItemSeleccionado = ""
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pickerStyles: UIPickerView!
    let defaults = UserDefaults.standard
    var token = ""
    let pickerData = ["BlackWork", "Neotradicional", "Tradicional", "Tradicional Japonés", "Realista"]
    @IBOutlet weak var imagenSeleccionada: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerItemSeleccionado = pickerData[2]
        tituloField.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1137254902, alpha: 1)
        tituloField.attributedPlaceholder = NSAttributedString(
            string: "Título del Post",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
               view.addGestureRecognizer(tapGesture)
        token = defaults.string(forKey: "token")!
        print(token)
        self.pickerStyles.delegate = self
        self.pickerStyles.dataSource = self
        pickerStyles.selectRow(2, inComponent: 0, animated: true)
        self.textView.delegate = self
        textView.text = "Introduce una descripción"
        textView.textColor = UIColor.lightGray
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 9
        textView.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1137254902, alpha: 1)
        imagenSeleccionada.layer.borderWidth = 1
        imagenSeleccionada.layer.borderColor = UIColor.black.cgColor
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Introduce una descripción."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerItemSeleccionado = pickerData[row]
    }
    
    @IBAction func enviarBoton(_ sender: Any) {
        let url = "http://desarrolladorapp.com/inkme/public/api/subirImagen"
        AF.upload(multipartFormData: { multipartformdata in
            multipartformdata.append(self.imageURL!, withName: "imagen")
        }, to: url, method: .post).responseDecodable(of: ResponseSubir.self){ response in
            let url = response.value?.url
            let urlpeticion = "http://desarrolladorapp.com/inkme/public/api/crearPost"
            let json = ["api_token": self.token, "description": self.textView.text, "photo": url!, "title": self.tituloField.text!, "style": self.pickerItemSeleccionado, "bcolor": 1] as [String : Any]
            AF.request(urlpeticion, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseSubirPost.self) { response in
                print("pickk",self.pickerItemSeleccionado)
                print(response)
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
    
    
    
    @IBAction func seleccionarSource(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        let actionSheet = UIAlertController(title: "Origen de la Foto", message: "Selecciona una opción", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camara", style: .default, handler: { (action: UIAlertAction) in
            
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { (action: UIAlertAction) in
            picker.sourceType = .photoLibrary
            // picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    
}

extension SubirViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        
        
        let image = info[.imageURL] as? URL
        textoSeleccion.isHidden = true
        guard let imagen = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        
        imageURL = image
        imagenSeleccionada.image = imagen
    }
    
    @objc func tapGestureHandler() {
        tituloField.endEditing(true)
        textView.endEditing(true)
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
