//
//  MiPostViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 1/3/22.
//

import UIKit
import AlamofireImage
import Alamofire
class MiPostViewController: UIViewController {

    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var usuarioPerfil: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var imagenSeleccionada: UIImageView!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var imagenperfil: UIImageView!
    let defaults = UserDefaults.standard
    var imagenUrl:String?
    var descripcionTexto:String?
    var usuarioPerfilTexto:String?
    var perfilpicurl:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenUrl = defaults.string(forKey: "urlMiPerfil")
        let url = URL(string: imagenUrl ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
        imagenSeleccionada.af.setImage(withURL: url!)
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        descripcion.numberOfLines = 0
        descripcion.lineBreakMode = NSLineBreakMode.byWordWrapping
        vista.layer.cornerRadius = 10
        
        
        //REQUEST
        let id = defaults.integer(forKey: "idMiPerfil")
        let url2 = "http://desarrolladorapp.com/inkme/public/api/cargarPost"
        let json = ["post_id": id]
        AF.request(url2, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseMiPost.self) { [self] response in
            print(response)
            if (response.value?.post) != nil {
                self.descripcionTexto = response.value?.post?.description
                self.usuarioPerfilTexto = response.value?.usuario?.name
                self.perfilpicurl = response.value?.usuario?.profile_picture
                let urlPP = URL(string: self.perfilpicurl!)
                imagenperfil.af.setImage(withURL: urlPP!)
                descripcion.text = descripcionTexto
                usuarioPerfil.text = usuarioPerfilTexto
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        //FIN REQUEST
        
        
        
    }

}



struct ResponseMiPost:Decodable{
    let post: FotoMiPerfil?
    let usuario: UsuarioMiPerfil?
}

struct FotoMiPerfil:Decodable {
    let id: Int?
    let user_id: String?
    let description: String?
}

struct UsuarioMiPerfil:Decodable {
    let name: String?
    let profile_picture: String?
}
