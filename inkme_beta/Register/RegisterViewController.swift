//
//  RegisterViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 14/1/22.
//
//nombre, telefono, email, contraseña, repetir contraseña
import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var token = ""
    var userId = 0
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatedPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.keyboardType = .phonePad
        email.keyboardType = .emailAddress
        title = "Registrarse"
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        name.attributedPlaceholder = NSAttributedString(
            string: "| Nickname",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        phone.attributedPlaceholder = NSAttributedString(
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
        
        repeatedPassword.attributedPlaceholder = NSAttributedString(
            string: "| Repetir Contraseña",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        )
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func botonRegistrar(_ sender: Any) {

        let url = "http://desarrolladorapp.com/inkme/public/api/register"
        let name = name.text
        let email = email.text
        let password = password.text
        let phoneNumber = phone.text
        let json = ["name": name, "password": password,"email": email, "numtlf": phoneNumber]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: RegisterResponse.self) { [self] response in
            print("sapsioopas",response)
            if (response.value?.status) == 1 {
                self.token = (response.value?.api_token)!
                defaults.setValue(self.token, forKey: "token")
                self.userId = (response.value?.user?.id)!
                defaults.setValue(self.userId, forKey: "id")
                performSegue(withIdentifier: "AtutorialUsuario", sender: nil)
            }else{
                print("an error has occured")
            }
        }
    }
    
    
    
    func checkTelefono(){
        let set = CharacterSet(charactersIn: phone.text!)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            showAlert(error: "Teléfono erróneo", mensaje: "El teléfono solo puede contener numeros")
        }
        if phone.text!.count > 9 || phone.text!.count < 9{
            showAlert(error: "Teléfono erróneo", mensaje: "El teléfono no tiene que llevar prefijo y debe de tener 9 caracteres")
        }
    }
    
    func validateEmail(field: UITextField) -> String? { //valida email, si el nill es que algo esta mal, si no, deja pasar
        guard let trimmedText = field.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return nil
        }
        
        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return nil
        }
        
        let range = NSMakeRange(0, NSString(string: trimmedText).length)
        let allMatches = dataDetector.matches(in: trimmedText,
                                              options: [],
                                              range: range)
        
        if allMatches.count == 1,
           allMatches.first?.url?.absoluteString.contains("mailto:") == true
        {
            return trimmedText
        }
        return nil
    }
    
    func validateNickname(field: UITextField){
        if field.text!.count == 0{
            showAlert(error: "Nickname erróneo", mensaje: "El nickname no puede estar vacío")
        }
        if field.text!.count > 12 {
            showAlert(error: "Nickname erróneo", mensaje: "El nickname no puede tener más de 12 caracteres")
        }
    }
    
    func validatePassword(field: String) -> Bool{
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return password.evaluate(with: field)
    }
    
    func repeatPassword(field: String) -> Bool{
        if (field == password.text!){
            return true
        }else{
            return false
        }
    }
    
    @objc func tapGestureHandler() {
        name.endEditing(true)
        phone.endEditing(true)
        email.endEditing(true)
        password.endEditing(true)
        repeatedPassword.endEditing(true)
    }
    
    func showAlert(error: String, mensaje: String){
        let alert = UIAlertController(title: "\(error)", message: "\(mensaje)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            print("Tapped Acept")
        }))
        present(alert, animated: true)
    }
}


