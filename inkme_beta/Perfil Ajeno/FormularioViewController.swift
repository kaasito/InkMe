//
//  FormularioViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 17/3/22.
//

import UIKit
import Alamofire
import AlamofireImage
class FormularioViewController: UIViewController {

    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var textView: UITextView!
    var id:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
               view.addGestureRecognizer(tapGesture)
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
    }
    @IBAction func enviarPressed(_ sender: Any) {
        let url = "http://desarrolladorapp.com/inkme/public/api/enviarFormulario"
        let json = ["usuario_id": id, "nombre": nombre.text, "comentario": textView.text, "telefono": telefono.text] as [String : Any]
        AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseFormulario.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                print("enviado")
            }else{
                print("no se ha podido hacer fetch")
            }
        }
    }
}


struct ResponseFormulario:Decodable {
    let status:Int?
    let msg:String?
}
