//
//  PostAjenoViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 2/3/22.
//

import UIKit
import AlamofireImage
class PostAjenoViewController: UIViewController {

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var imagenAcARGAR: UIImageView!
    var url: URL?
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var nicknameajeno: UILabel!
    @IBOutlet weak var descripcionajeno: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["desarrolladorapp.com/inkme/public/post/\(defaults.integer(forKey: "idPostAjeno"))"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
}


