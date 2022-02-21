//
//  MiPerfilViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 7/2/22.
//

import UIKit
import Alamofire

class MiPerfilViewController: UIViewController {

    @IBOutlet weak var nombrePerfil: UILabel!
    @IBOutlet weak var segmentado: UISegmentedControl!
    @IBOutlet weak var ubicacionLabel: UILabel!
    @IBOutlet weak var estiloLabel: UILabel!
    let defaults = UserDefaults.standard
    @IBOutlet weak var tutorial: UIView!
    @IBOutlet weak var vistaInfo: UIView!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var merchView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.string(forKey: "token") == nil{
            vistaInfo.isHidden = true
            postView.isHidden = true
            merchView.isHidden = true
            segmentado.isHidden = true
        }else{
            tutorial.isHidden = true
            let url = "http://localhost:8888/inkme/public/api/cargarPerfil"
            let idUsuario = defaults.integer(forKey: "id")
            let json = ["usuario_id": String(idUsuario)]
            print(json)
            AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: PerfilResponse.self) { [self] response in
                print("response",response)
                if (response.value?.status) == 1 {
                    self.nombrePerfil.text = response.value?.usuario?.nombre
                    let url = URL(string: response.value?.usuario?.foto ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
                    self.imagenPerfil.af.setImage(withURL: url!)
                    self.estiloLabel.text = response.value?.usuario?.styles ?? "sin estilo"
                    self.ubicacionLabel.text = response.value?.usuario?.ubicacion ?? "sin ubicacion"
                    
                }else{
                    print("no se ha podido hacer fetch")
                }
            }
        }
        vistaInfo.layer.cornerRadius = 10
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        postView.alpha = 1
        merchView.alpha = 0
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
     
    }
    

    @IBAction func cambiador(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            postView.alpha = 1
            merchView.alpha = 0
        }else{
            postView.alpha = 0
            merchView.alpha = 1
        }
    }

}
extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}

func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(String(describing: isAppAlreadyLaunchedOnce))")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }


struct PerfilResponse:Decodable {
    let status: Int?
    let usuario: UsuarioPropio?
}

struct UsuarioPropio:Decodable{
 
    let nombre: String?
    let email: String?
    let foto: String?
    let ubicacion: String?
    let styles: String?
}


/*
 "nombre": "Lucas",
         "email": "lucas@gmail.com",
         "foto": "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2021/01/18/16109969864752.png",
         "ubicacion": "Madrid",
         "estudio_id": null,
         "styles": "blackwork",
         "posts": [
             {
                 "id": 1,
                 "photo": "https://image-service.onefootball.com/transform?w=280&h=210&dpr=2&image=https%3A%2F%2Findependientehoy.com%2Fwp-content%2Fuploads%2F2021%2F06%2Flucas-romero-en-entrevista.jpg"
             },
             {
                 "id": 2,
                 "photo": "https://pbs.twimg.com/media/FI1TuXtXoBI9h_E?format=jpg&name=large"
             },
             {
                 "id": 3,
                 "photo": "https://pbs.twimg.com/media/EY6DDjcXsAM6rB0.jpg"
             }
         ]
     }
 }
 */
