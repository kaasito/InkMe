//
//  MiPerfilViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 7/2/22.
//

import UIKit

class MiPerfilViewController: UIViewController {

    @IBOutlet weak var segmentado: UISegmentedControl!
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
