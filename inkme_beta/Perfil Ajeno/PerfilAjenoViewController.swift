//
//  PerfilAjenoViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 7/2/22.
//

import UIKit
import Alamofire
import AlamofireImage
class PerfilAjenoViewController: UIViewController {
    var nombre:String?
    var ubicacion:String?
    var estilo:String?
    var id:Int?
    @IBOutlet weak var ubicacionLabel: UILabel!
    @IBOutlet weak var estiloLabel: UILabel!
    var imagenPerfilString:String?
    @IBOutlet weak var vistaBlanca: UIView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var compartirBoton: UIButton!
    @IBOutlet weak var merchView: UIView!
    @IBOutlet weak var postView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let sv = PerfilAjenoCollectionViewController()
    
    
      print("el ide del perfilajeno",id)
        let urlImagen = URL(string: imagenPerfilString ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg")
        imagenPerfil.af.setImage(withURL: urlImagen!)
        imagenPerfil.layer.cornerRadius = imagenPerfil.frame.size.width / 2
        imagenPerfil.clipsToBounds = true
        postView.alpha = 1
        merchView.alpha = 0
        compartirBoton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        compartirBoton.setImageTintColor(UIColor.systemBlue)
        vistaBlanca.layer.cornerRadius = 10
        nickname.text = nombre
        ubicacionLabel.text = ubicacion
        estiloLabel.text = estilo
        
        
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
