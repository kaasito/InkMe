//
//  RegisterViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 14/1/22.
//
//nombre, telefono, email, contraseña, repetir contraseña
import UIKit

class RegisterViewController: ViewController {


    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repetir: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registrarse"
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
               view.addGestureRecognizer(tapGesture)
        
        nombre.attributedPlaceholder = NSAttributedString(
            string: "| Nickname",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        telefono.attributedPlaceholder = NSAttributedString(
            string: "| Telefono",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        email.attributedPlaceholder = NSAttributedString(
            string: "| Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        password.attributedPlaceholder = NSAttributedString(
            string: "| Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        repetir.attributedPlaceholder = NSAttributedString(
            string: "| Repetir Contraseña",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
       
        // Do any additional setup after loading the view.
    }
    
    @objc func tapGestureHandler() {
        nombre.endEditing(true)
        telefono.endEditing(true)
        email.endEditing(true)
        password.endEditing(true)
        repetir.endEditing(true)
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
