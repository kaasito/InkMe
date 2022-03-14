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
    var url = ""
    var id = 0
    @IBOutlet weak var imagen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
        saveButton.setImage(UIImage(systemName: "plus"), for: .normal)
        saveButton.setImage(UIImage(systemName: "plus"), for: .highlighted)
        saveButton.setImageTintColor(UIColor.systemBlue)
        print("curretn",saveButton.currentImage)
        vistaLabel.layer.cornerRadius = 10
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        let url1 = URL(string:url)
        imagen.af.setImage(withURL: url1!)
        desc.numberOfLines = 0
        desc.lineBreakMode = NSLineBreakMode.byWordWrapping
        let url2 = "http://desarrolladorapp.com/inkme/public/api/cargarPost"
        let json = ["post_id": id]
        AF.request(url2, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponsePost.self) { response in
            print(response)
            if (response.value?.post) != nil {
                
                self.nombreUsuario = response.value?.usuario?.name
                self.nicknamelabel.text = self.nombreUsuario
                let url = URL(string: (response.value?.usuario?.profile_picture) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
                self.imagenPerfil.af.setImage(withURL: url!)
                self.desc.text = response.value?.post?.description
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
      
        
        
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
}

struct ResponsePost: Decodable{
    let post: Foto?
    let usuario: Usuario?
}

struct Foto:Decodable {
    let id: Int?
    let user_id: String?
    let description: String?
}

struct Usuario:Decodable {
    let name: String?
    let profile_picture: String?
}

