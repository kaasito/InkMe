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
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
//        defaults.setValue(response.value?.user?.email, forKey:"email")
//        defaults.setValue(response.value?.user?.numtlf, forKey:"tlf")
//        defaults.setValue(response.value?.user?.name, forKey:"name")
        
        telefonoField.text = defaults.string(forKey: "tlf")
        emailField.text = defaults.string(forKey: "email")
        //nombreField.text = defaults.string(forKey: "name")
        nombreField.text = "si"
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
    }
    
    
    @IBAction func guardarCambiosTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}

struct PerfilResponseEditar:Decodable {
    let status: Int?
    let usuario: UsuarioPropioEditar?
}

struct UsuarioPropioEditar:Decodable{
 
    let nombre: String?
    let email: String?
    let foto: String?
    let ubicacion: String?
    let styles: String?
}
