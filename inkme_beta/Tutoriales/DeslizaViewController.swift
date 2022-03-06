//
//  DeslizaViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 21/1/22.
//

import UIKit

class DeslizaViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let deslizaGif = UIImage.gifImageWithName("Desliza-hacia-abajo")
        imagen.image = deslizaGif// Do any additional setup after loading the view.
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
