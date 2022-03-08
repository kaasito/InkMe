//
//  EditarPerfilViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 7/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

class EditarPerfilViewController: UIViewController {
    
    @IBOutlet weak var telefonoField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var editarImagenButton: UIButton!
    @IBOutlet weak var imagenPerfil: UIImageView!
    var token = ""
    let defaults = UserDefaults.standard
    var imageURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
//        defaults.setValue(response.value?.user?.email, forKey:"email")
//        defaults.setValue(response.value?.user?.numtlf, forKey:"tlf")
//        defaults.setValue(response.value?.user?.name, forKey:"name")
        
        telefonoField.text = defaults.string(forKey: "tlf")
        emailField.text = defaults.string(forKey: "email")
        nombreField.text = defaults.string(forKey: "name")
      
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"
        let idUsuario = defaults.integer(forKey: "id")
        let json = ["usuario_id": String(idUsuario)]
        AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: PerfilResponseEditar.self) { [self] response in
            print("response",response)
            if (response.value?.status) == 1 {
                imagenPerfil.af.setImage(withURL: URL(string: (response.value?.usuario?.foto ??  "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg") )! )
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
    }
    
    
    @IBAction func editarImagenTapped(_ sender: Any) {
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
    
    
    @IBAction func guardarCambiosTapped(_ sender: Any) {
        let url = "http://desarrolladorapp.com/inkme/public/api/subirImagen"
        AF.upload(multipartFormData: { multipartformdata in
            multipartformdata.append(self.imageURL!, withName: "imagen")
        }, to: url, method: .post).responseDecodable(of: ResponseSubir.self){ [self] response in
            let url = response.value?.url
            token = defaults.string(forKey: "token")!
            let urlpeticion = "http://desarrolladorapp.com/inkme/public/api/editarPerfil"
            let nombre = nombreField.text
            let email = emailField.text
            let tlf = telefonoField.text
            print("nombreusuario", email)
            let json = ["api_token": self.token, "name": nombre, "email": email, "numtlf": tlf, "profile_picture": url!]
            AF.request(urlpeticion, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: PerfilResponseEditar.self) {
                response in
                
                if response.value?.status == 1{
                    defaults.setValue(nombre, forKey: "name")
                    defaults.setValue(tlf, forKey: "tlf")
                    defaults.setValue(email, forKey: "email")
                    let alert = UIAlertController(title: "Usuario editado con éxito!", message: "El usuario se ha editado exitosamente", preferredStyle: .alert)
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
                    let alert = UIAlertController(title: "Ha habido un error", message: "No se ha podido editar el usuario, revisa tu conexión.", preferredStyle: .alert)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}


extension EditarPerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
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
        imagenPerfil.image = imagen
    }
    
    
}

struct PerfilResponseEditar:Decodable {
    let status: Int?
    let usuario: UsuarioPropioEditar?
    let msg: String?
}

struct UsuarioPropioEditar:Decodable{
 
    let nombre: String?
    let email: String?
    let foto: String?
    let ubicacion: String?
    let styles: String?
}
