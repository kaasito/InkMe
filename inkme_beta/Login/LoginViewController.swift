//
//  LoginViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 13/1/22.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    var userdLoggedId = 0
    var apiToken = ""
    let defaults = UserDefaults.standard
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        email.keyboardType = .emailAddress
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
    
    @IBAction func logInPressed(_ sender: Any) {
        let email = email.text
        let password = password.text
        let url = "http://desarrolladorapp.com/inkme/public/api/login"
        let json = ["email": email, "password": password]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: LoginPantalla.self) { [self] response in
            if (response.value?.status) == 1 {
                self.apiToken = (response.value?.api_token)!
                self.userdLoggedId = (response.value?.user?.id)!
                defaults.setValue(self.apiToken, forKey:"token")
                defaults.setValue(self.userdLoggedId, forKey:"id")
                defaults.setValue(response.value?.user?.email, forKey:"email")
                defaults.setValue(response.value?.user?.numtlf, forKey:"tlf")
                defaults.setValue(response.value?.user?.name, forKey:"name")
                defaults.setValue(response.value?.user?.profile_picture, forKey:"profile_pic")
                defaults.setValue(response.value?.user?.location, forKey:"location")
                defaults.setValue(response.value?.user?.styles, forKey:"styles")
                performSegue(withIdentifier: "fromLogin", sender: nil)
            }else{
                print("no se ha podido hacer fetch")
            }
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

  

}





