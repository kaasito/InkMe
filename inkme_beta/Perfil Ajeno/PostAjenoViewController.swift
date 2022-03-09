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
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
        let imagen = defaults.string(forKey: "urlPostAjeno")!
        url = URL(string:imagen )
        imagenAcARGAR.af.setImage(withURL: url!)
    }
    

    @IBAction func shareButtonTapped(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["desarrolladorapp.com/inkme/public/post/\(defaults.integer(forKey: "idPostAjeno"))"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
}


