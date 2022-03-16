//
//  ResultadoMLViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 16/3/22.
//

import UIKit

class ResultadoMLViewController: UIViewController {
    @IBOutlet weak var estiloMasAccurateLabel: UILabel!
    var estiloMasAccurate:String?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        estiloMasAccurateLabel.text = estiloMasAccurate
        
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
