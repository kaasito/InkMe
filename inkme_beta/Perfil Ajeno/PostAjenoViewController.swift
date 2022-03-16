//
//  PostAjenoViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 2/3/22.
//

import UIKit
import AlamofireImage
class PostAjenoViewController: UIViewController {
    
    
    @IBOutlet weak var favbuton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var imagenAcARGAR: UIImageView!
    var url: URL?
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var nicknameajeno: UILabel!
    @IBOutlet weak var descripcionajeno: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        favbuton.setImage(UIImage(systemName: "plus"), for: .normal)
        favbuton.setImageTintColor(UIColor.systemBlue)
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
        let imagen = defaults.string(forKey: "urlPostAjeno")!
        url = URL(string:imagen )
        imagenAcARGAR.af.setImage(withURL: url!)
        imagenPerfil.af.setImage(withURL: URL(string: defaults.string(forKey: "profilePicPostAjeno")!)!)
        descripcionajeno.text = defaults.string(forKey: "descriptionPostAjeno")
        nicknameajeno.text = defaults.string(forKey: "nicknamePostAjeno")!
    }
    

    @IBAction func favsbutton(_ sender: Any) {
        let id = defaults.integer(forKey: "idPostAjeno")
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
    @IBAction func perfilPressed(_ sender: Any) {
      performSegue(withIdentifier: "toProfileAjeno", sender: nil)
    }
    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["desarrolladorapp.com/inkme/public/post/\(defaults.integer(forKey: "idPostAjeno"))"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfileAjeno"{
            let destinationController = segue.destination as! PerfilAjenoViewController
            destinationController.id = defaults.integer(forKey: "usuarioAjeno")
            destinationController.imagenPerfilString = defaults.string(forKey: "profilePicPostAjeno")
            destinationController.nombre = defaults.string(forKey: "nicknamePostAjeno")
            destinationController.estilo = defaults.string(forKey: "stylesPostAjeno")
            destinationController.ubicacion = defaults.string(forKey: "locationPostAjeno")
        }
    }
}


