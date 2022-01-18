//
//  CamaraViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit

class CamaraViewController: ViewController {

    @IBOutlet var imagenSeleccionada: UIImageView!
    @IBOutlet weak var botonCamara: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func abrirCamara(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
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

