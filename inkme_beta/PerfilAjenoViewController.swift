//
//  PerfilAjenoViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 7/2/22.
//

import UIKit

class PerfilAjenoViewController: UIViewController {

    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var compartirBoton: UIButton!
    @IBOutlet weak var merchView: UIView!
    @IBOutlet weak var postView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        postView.alpha = 1
        merchView.alpha = 0
        compartirBoton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        compartirBoton.setImageTintColor(UIColor.systemBlue)
    }
    
    @IBAction func segmentedView(_ sender: UISegmentedControl) {
       
        if sender.selectedSegmentIndex == 0{
            postView.alpha = 1
            merchView.alpha = 0
        }else{
            postView.alpha = 0
            merchView.alpha = 1
        }
    }
    
    /*
   
    */

}
