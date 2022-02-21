//
//  RegisterViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 14/1/22.
//
//nombre, telefono, email, contraseña, repetir contraseña
import UIKit
import Alamofire

class RegisterViewController: ViewController {
    
    let defaults = UserDefaults.standard
    var token = ""
    var userId = 0
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
    
    
    @IBAction func botonRegistrar(_ sender: Any) {
       
//        validarNickName(field: nombre)
//        checkTelefono()
//
//        if validateEmail(field: email) == nil{
//            showAlert(error: "Email erróneo", mensaje: "El email es obligatorio, no debe contener espacios en blanco, y debe seguir un formato correcto xxx@xxx.xx")
//        }
//
//        if repetirPassword(field: repetir.text!) == false{
//            showAlert(error: "La contraseña no coincide", mensaje: "La contraseña repetida no coincide con la contraseña introducida")
//        }
        
        let url = "http://localhost:8888/inkme/public/api/register"
        let name = nombre.text
        let email = email.text
        let password = password.text
        let numtlf = telefono.text
        let json = ["name": name, "password": password,"email": email, "numtlf": numtlf]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: RegisterResponse.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.token = (response.value?.api_token)!
                defaults.setValue(self.token, forKey: "token")
                self.userId = (response.value?.id)!
                defaults.setValue(self.userId, forKey: "id")
                performSegue(withIdentifier: "AtutorialUsuario", sender: nil)
            }else{
                print("no se ha podido hacer fetch")
            }
        }
      
        /*
             "name": "Adri",
             "email": "adri@gmail.com",
             "password": "Lui$11",
             "numtlf": "665679453"
         */
      
    }
    
    
    
    func checkTelefono(){
        let set = CharacterSet(charactersIn: telefono.text!)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            showAlert(error: "Teléfono erróneo", mensaje: "El teléfono solo puede contener numeros")
        }
        if telefono.text!.count > 9 || telefono.text!.count < 9{
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
    
    func validarNickName(field: UITextField){
        if field.text!.count == 0{
            showAlert(error: "Nickname erróneo", mensaje: "El nickname no puede estar vacío")
        }
        if field.text!.count > 12 {
            showAlert(error: "Nickname erróneo", mensaje: "El nickname no puede tener más de 12 caracteres")
        }
    }
    
    func validarPassword(field: String) -> Bool{
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return password.evaluate(with: field)
    }
    
    func repetirPassword(field: String) -> Bool{
        if (field == password.text!){
            return true
        }else{
            return false
        }
    }
    
    
    
    
    @objc func tapGestureHandler() {
        nombre.endEditing(true)
        telefono.endEditing(true)
        email.endEditing(true)
        password.endEditing(true)
        repetir.endEditing(true)
    }
    
    func showAlert(error: String, mensaje: String){
        let alert = UIAlertController(title: "\(error)", message: "\(mensaje)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            print("Tapped Acept")
        }))
        present(alert, animated: true)
    }
    
    
}

struct RegisterResponse:Decodable{
    let status: Int?
    let api_token: String?
    let id:Int?
}
