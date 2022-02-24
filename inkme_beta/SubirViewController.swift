//
//  SubirViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 24/2/22.
//

import UIKit
import Alamofire
import AlamofireImage
class SubirViewController: UIViewController {
    var imageURL: URL?
    @IBOutlet weak var imagenSeleccionada: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
   
    @IBAction func enviarBoton(_ sender: Any) {
        let url = "http://desarrolladorapp.com/gestionImagenes/public/api/subirImagen"
       // let urrl = URL(string: url)
       // let image = imagenSeleccionada.image
       // let imageData = image!.pngData() //el data
       
        AF.upload(multipartFormData: { multipartformdata in
            multipartformdata.append(self.imageURL!, withName: "imagen")
        }, to: url, method: .post).response{ response in
            print(response)
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

extension SubirViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
       
        
        let image = info[.imageURL] as? URL
        guard let imagen = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }

        imageURL = image
        imagenSeleccionada.image = imagen
    }
    
    
}


struct ResponseSubir:Decodable{
    let status: Int?
}


