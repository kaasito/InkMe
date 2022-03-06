//
//  PostAjenoViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 2/3/22.
//

import UIKit
import AlamofireImage
class PostAjenoViewController: UIViewController {

    @IBOutlet weak var imagenAcARGAR: UIImageView!
    var url: URL?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagen = defaults.string(forKey: "urlPostAjeno")!
        url = URL(string:imagen )
        imagenAcARGAR.af.setImage(withURL: url!)
    }
    

   
}


