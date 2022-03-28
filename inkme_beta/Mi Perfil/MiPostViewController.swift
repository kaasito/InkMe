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

    @IBOutlet weak var shareButton: UIButton!
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
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
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
        AF.request(url2, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseFoto.self) { [self] response in
            print(response)
            if (response.value?.post) != nil {
                self.descripcionTexto = response.value?.post?.description
                self.usuarioPerfilTexto = response.value?.user?.name
                self.perfilpicurl = response.value?.user?.profile_picture ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg"
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

    @IBAction func aMiperfil(_ sender: Any) {
        performSegue(withIdentifier: "aMiPerfil", sender: nil)
    }
    @IBAction func shareButtonTap(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["desarrolladorapp.com/inkme/public/post/\(defaults.integer(forKey: "idMiPerfil"))"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        
    }
}






