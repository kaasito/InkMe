//
//  PostViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/2/22.
//

import UIKit
import Alamofire
import AlamofireImage

class PostViewController: UIViewController {

    
    
    @IBOutlet weak var vistaLabel: UIView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var nicknamelabel: UILabel!
    var nombreUsuario: String?
    var url = ""
    var id = 0
    @IBOutlet weak var imagen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        let url1 = URL(string:url)
        imagen.af.setImage(withURL: url1!)
        desc.numberOfLines = 0
        desc.lineBreakMode = NSLineBreakMode.byWordWrapping
        let url2 = "http://localhost:8888/inkme/public/api/cargarPost"
        let json = ["post_id": id]
        AF.request(url2, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponsePost.self) { response in
            print(response)
            if (response.value?.post) != nil {
                
                self.nombreUsuario = response.value?.usuario?.name
                self.nicknamelabel.text = self.nombreUsuario
                let url = URL(string: (response.value?.usuario?.profile_picture)!)
                self.imagenPerfil.af.setImage(withURL: url!)
                self.desc.text = response.value?.post?.description
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
      
        
        
    }
    

   
}

struct ResponsePost: Decodable{
    let post: Foto?
    let usuario: Usuario?
}

struct Foto:Decodable {
    let id: Int?
    let user_id: Int?
    let description: String?
}

struct Usuario:Decodable {
    let name: String?
    let profile_picture: String?
}

