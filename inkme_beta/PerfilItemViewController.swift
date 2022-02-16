//
//  PerfilItemViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 8/2/22.
//

import UIKit

class PerfilItemViewController: UIViewController {

    @IBOutlet weak var vistaPerfil: UIView!
    @IBOutlet weak var vistaIniciarSesion: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vistaPerfil.alpha = 1
        vistaIniciarSesion.alpha = 0
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
