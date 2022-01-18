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
    
    @IBAction func iniciarSesion(_ sender: Any) {
        if password.text!.count < 10{
            showAlert(error: "Contraseña inválida", mensaje: "Contraseña incorrecta")
        }
        
    }
    @objc func tapGestureHandler() {
        email.endEditing(true)
        password.endEditing(true)
      }
    func showAlert(error: String, mensaje: String){
        let alert = UIAlertController(title: "\(error)", message: "\(mensaje)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            print("Tapped Acept")
        }))
        present(alert, animated: true)
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
