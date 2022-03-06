//
//  MainProfileViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 13/1/22.
//

import UIKit

class MainProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Perfil"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes //pone el titulo en blanco
      
        // Do any additional setup after loading the view.
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
