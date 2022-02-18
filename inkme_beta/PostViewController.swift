//
//  PostViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/2/22.
//

import UIKit
import Alamofire
import AlamofireImage

class PostViewController: UIViewController {

    var url = ""
    @IBOutlet weak var imagen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url1 = URL(string:url)
        imagen.af.setImage(withURL: url1!)
        
      
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
