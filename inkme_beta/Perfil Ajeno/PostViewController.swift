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
    
    

    var ids:[Int] = []
    let defaults = UserDefaults.standard
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var vistaLabel: UIView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var nicknamelabel: UILabel!
    var nombreUsuario: String?
    var jsonn: [String:Any]?
    var url = ""
    var id = 0
    var profilePic:String?
    var usuarioId:Int?
    var ubicacion:String?
    var estilos:String?
    @IBOutlet weak var imagen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
        saveButton.setImage(UIImage(systemName: "plus"), for: .normal)
        saveButton.setImageTintColor(UIColor.systemBlue)
        vistaLabel.layer.cornerRadius = 10
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        let url1 = URL(string:url)
        imagen.af.setImage(withURL: url1!)
        desc.numberOfLines = 0
        desc.lineBreakMode = NSLineBreakMode.byWordWrapping
        let url2 = "http://desarrolladorapp.com/inkme/public/api/cargarPost"
        let json = ["post_id": id]
        AF.request(url2, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseFoto.self) { response in
            print(response)
            if (response.value?.post) != nil {
                
                self.nombreUsuario = response.value?.user?.name
                self.nicknamelabel.text = self.nombreUsuario
                let url = URL(string: (response.value?.user?.profile_picture) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
                self.profilePic = response.value?.user?.profile_picture
                self.imagenPerfil.af.setImage(withURL: url!)
                self.desc.text = response.value?.post?.description
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
      
        
        
    }
    
    @IBAction func profilePressed(_ sender: Any) {
       
        performSegue(withIdentifier: "toProfile2", sender: nil)
    }
    
    @IBAction func copartirTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["desarrolladorapp.com/inkme/public/post/\(id)"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func favoritoPressed(_ sender: Any) {
      
        if defaults.array(forKey: "favoritos") != nil{
            var nums = UserDefaults.standard.array(forKey: "favoritos") as! [Int]
            nums.insert(id, at: 0)
            UserDefaults.standard.set(nums, forKey: "favoritos")
        }else{
          defaults.set([Int](), forKey: "favoritos")
            var nums = UserDefaults.standard.array(forKey: "favoritos") as! [Int]
            nums.insert(id, at: 0)
            UserDefaults.standard.set(nums, forKey: "favoritos")
            
            
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile2"{
            let destinationController = segue.destination as! PerfilAjenoViewController
            destinationController.id = defaults.integer(forKey: "usuarioIdLista")
            destinationController.imagenPerfilString = profilePic
            destinationController.nombre = nicknamelabel.text
            destinationController.estilo = defaults.string(forKey: "estilosIdLista")
            destinationController.ubicacion = defaults.string(forKey: "ubicacionIdLista")
            let userId = defaults.integer(forKey: "usuarioIdLista")
            let url = "http://desarrolladorapp.com/inkme/public/api/sumarViewPerfil"
            let apiiitoken = defaults.string(forKey: "token")
            
            if apiiitoken == nil{
                jsonn = ["api_token": "", "user_id": userId]
               
            }else{
                jsonn = ["api_token": apiiitoken!,"user_id": userId]
               
            }
            
            AF.request(url, method: .put, parameters: jsonn,encoding: JSONEncoding.default).responseDecodable (of: ResponseStatusMsg.self) { response in
                print("ashjagsjhags",response)
            }
        }
    }



}
