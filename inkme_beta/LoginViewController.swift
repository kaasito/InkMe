//
//  LoginViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 13/1/22.
//

import UIKit

class LoginViewController: ViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
               view.addGestureRecognizer(tapGesture)
        email.attributedPlaceholder = NSAttributedString(
            string: "| Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        password.attributedPlaceholder = NSAttributedString(
            string: "| Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        // Do any additional setup after loading the view.
    }
    @objc func tapGestureHandler() {
        email.endEditing(true)
        password.endEditing(true)
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
