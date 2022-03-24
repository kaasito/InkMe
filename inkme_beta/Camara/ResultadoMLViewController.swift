//
//  ResultadoMLViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 16/3/22.
//

import UIKit

class ResultadoMLViewController: UIViewController {
    @IBOutlet weak var mostAccurateStyleLabel: UILabel!
    var mostAccurateStyle:String?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        mostAccurateStyleLabel.text = mostAccurateStyle
        
    }

}
