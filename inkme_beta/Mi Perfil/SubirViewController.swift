//
//  SubirViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 24/2/22.
//

import UIKit
import Alamofire
import AlamofireImage


class SubirViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate{
    @IBOutlet weak var textoSeleccion: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    var imageURL: URL?
    var pickerItemSelected = ""
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pickerStyles: UIPickerView!
    let defaults = UserDefaults.standard
    var token = ""
    let pickerData = ["BlackWork", "Neotradicional", "Tradicional", "Tradicional Japonés", "Realista"]
    var imageUploaded:Bool = false
    @IBOutlet weak var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action:     #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        self.pickerStyles.delegate = self
        self.pickerStyles.dataSource = self
        self.textView.delegate = self
        
       
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Título del Post",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
       
        
        pickerItemSelected = pickerData[2]
        pickerStyles.selectRow(2, inComponent: 0, animated: true)
        token = defaults.string(forKey: "token")!
        titleTextField.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1137254902, alpha: 1)
        textView.text = "Introduce una descripción"
        textView.textColor = UIColor.lightGray
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 9
        textView.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1137254902, alpha: 1)
        selectedImage.layer.borderWidth = 1
        selectedImage.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func justPressedSendButton(_ sender: Any) {
        if textView.text != "" && titleTextField.text != "" && imageUploaded == true{
            uploadAndPublishPicture()
        }else{
            let alert = UIAlertController(title: "No se ha subido la foto", message: "Tienes que rellenar todo y poner una imagen", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Vale", style: .destructive, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                @unknown default:
                   print("fatalError")
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    func uploadAndPublishPicture(){
        guard let imageURL = self.imageURL else {
            // saca un alert
            return
        }
        
        let url = "http://desarrolladorapp.com/inkme/public/api/subirImagen"
      
        AF.upload(multipartFormData: { multipartformdata in
            multipartformdata.append(imageURL , withName: "imagen")
        }, to: url, method: .post).responseDecodable(of: ResponseSubir.self){ response in
            let url = response.value?.url
            let urlpeticion = "http://desarrolladorapp.com/inkme/public/api/crearPost"
            let json = ["api_token": self.token, "description": self.textView.text!, "photo": url!, "title": self.titleTextField.text!, "style": self.pickerItemSelected, "bcolor": 1] as [String : Any]
            AF.request(urlpeticion, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponseSubirPost.self) { response in
                print("pickk",self.pickerItemSelected)
                print(response)
                if response.value?.status == 1{
                    
                    let alert = UIAlertController(title: "Foto publicada con éxito!", message: "La foto se ha subido exitosamente", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Vale", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                        @unknown default:
                            print("fatalError")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Ha habido un error", message: "No se ha podido subir la foto, revisa tu conexión.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Vale", style: .destructive, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("fatalError")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

    }
    
    @IBAction func selectSource(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        let actionSheet = UIAlertController(title: "Origen de la Foto", message: "Selecciona una opción", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camara", style: .default, handler: { (action: UIAlertAction) in
            
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { (action: UIAlertAction) in
            picker.sourceType = .photoLibrary
            // picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func filePath(forKey key: String = "imagen") -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    private func saveImage(_ imagen: UIImage) -> URL? {
        
        guard let imageURL = filePath() else { return nil }
        //guard let data = imagen.pngData() else { return nil }
        guard let data = imagen.jpegData(compressionQuality: 0.5) else { return nil }
        do {
            try data.write(to: imageURL)
            return imageURL
        }
        catch {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerItemSelected = pickerData[row]
    }
    
}

extension SubirViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[.imageURL] as? URL
        textoSeleccion.isHidden = true
        guard let imagen = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        
        if image == nil{
            imageURL = saveImage(imagen)
        }else{
            imageURL = image
        }
        
       
        selectedImage.image = imagen
        imageUploaded = true
    }
    
    
    @objc func tapGestureHandler() {
        titleTextField.endEditing(true)
        textView.endEditing(true)
    }
}




