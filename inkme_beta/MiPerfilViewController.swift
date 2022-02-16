//
//  MiPerfilViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 7/2/22.
//

import UIKit

class MiPerfilViewController: UIViewController {

    
    @IBOutlet weak var vistaInfo: UIView!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var merchView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        vistaInfo.layer.cornerRadius = 10
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        postView.alpha = 1
        merchView.alpha = 0
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setImageTintColor(UIColor.systemBlue)
        
        //button.setImage(UIImage(named: "image_name"), for: .normal) // You can set image direct from Storyboard
        //button.setImageTintColor(UIColor.white)
       
//        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "id") as? NavViewController {
//            viewController.modalPresentationStyle = .fullScreen
//            self.present(viewController, animated: true, completion: nil)
//        }
        
     
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
