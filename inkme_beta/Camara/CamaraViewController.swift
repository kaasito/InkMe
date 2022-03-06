//
//  CamaraViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit

class CamaraViewController: UIViewController {
    
    
    @IBOutlet weak var botonBuscar: UIButton!
    @IBOutlet var imagenSeleccionada: UIImageView!
    @IBOutlet weak var botonCamara: UIButton!
    @IBOutlet weak var botonGaleria: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func abrirGaleria(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func abrirCamara(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    
    @IBAction func buscarPulsado(_ sender: Any) {
        if imagenSeleccionada.image == nil{
            let alert = UIAlertController(title: "Error", message: "Tienes que subir una foto para realizar una busqueda", preferredStyle: .alert)
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
        }
    }
}

extension CamaraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
       
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        imagenSeleccionada.image = image
    }
    
}

