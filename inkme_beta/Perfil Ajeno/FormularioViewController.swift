//
//  FormularioViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 17/3/22.
//

import UIKit
import Alamofire
import AlamofireImage
class FormularioViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var pickerdate: UIDatePicker!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var textView: UITextView!
    var id:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
               view.addGestureRecognizer(tapGesture)
        pickerdate.setValue(UIColor.white, forKeyPath: "textColor")
        pickerdate.setValue(false, forKeyPath: "highlightsToday")
        self.textView.delegate = self
        textView.text = "Introduce la información de tu consulta"
        textView.textColor = UIColor.lightGray
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 9
        textView.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1137254902, alpha: 1)
        
    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Introduce una descripción."
            textView.textColor = UIColor.lightGray
        }
    }
    @objc func tapGestureHandler() {
        textView.endEditing(true)
        nombre.endEditing(true)
        telefono.endEditing(true)
    }
    @IBAction func enviarPressed(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: pickerdate.date)
    
        let url = "http://desarrolladorapp.com/inkme/public/api/enviarFormulario"
        let json = ["usuario_id": id, "nombre": nombre.text, "comentario": textView.text, "telefono": telefono.text, "date": selectedDate] as [String : Any]
        AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseFormulario.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                let alert = UIAlertController(title: "Enviado con éxito", message: "El tatuador ha recibido tu petición", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: { action in
                    switch action.style{
                        case .default:
                        print("default")
                        
                        case .cancel:
                        print("cancel")
                        
                        case .destructive:
                        print("destructive")
                        
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "No se ha podido mandar la petición, revisa tu conexión", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Vale", style: .destructive, handler: { action in
                    switch action.style{
                        case .default:
                        print("default")
                        
                        case .cancel:
                        print("cancel")
                        
                        case .destructive:
                        print("destructive")
                        
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


struct ResponseFormulario:Decodable {
    let status:Int?
    let msg:String?
}
