//
//  LoginViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 13/1/22.
//

import UIKit
import Alamofire

class LoginViewController: ViewController {
    var idUsuarioLogueado = 0
    var api_token = ""
    let defaults = UserDefaults.standard
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
        let correo = email.text
        let contra = password.text
        let url = "http://desarrolladorapp.com/inkme/public/api/login"
        let json = ["email": correo, "password": contra]
        AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: LoginPantalla.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.api_token = (response.value?.api_token)!
                self.idUsuarioLogueado = (response.value?.id)!
                defaults.setValue(self.api_token, forKey:"token")
                defaults.setValue(self.idUsuarioLogueado, forKey:"id")
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


struct LoginPantalla:Decodable{
    let status: Int?
    let msg: String?
    let api_token: String?
    let id: Int?
}
