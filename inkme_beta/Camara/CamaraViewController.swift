//
//  CamaraViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit
import CoreML

class CamaraViewController: UIViewController {
    
   let model = TattooClasifier_1()
    var salida:String?
    let defaults = UserDefaults.standard
    @IBOutlet weak var botonBuscar: UIButton!
    @IBOutlet var imagenSeleccionada: UIImageView!
    @IBOutlet weak var botonGaleria: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func abrirGaleria(_ sender: Any) {
        
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
        
        let image = imagenSeleccionada.image
        let targetSize = CGSize(width: 299, height: 299)

        // Compute the scaling ratio for the width and height separately
        let widthScaleRatio = targetSize.width / image!.size.width
        let heightScaleRatio = targetSize.height / image!.size.height

        // To keep the aspect ratio, scale by the smaller scaling ratio
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)

        // Multiply the original image’s dimensions by the scale factor
        // to determine the scaled image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: image!.size.width * scaleFactor,
            height: image!.size.height * scaleFactor
        )
        
        let bufeada = imagenSeleccionada.image?.toBuffer()
        let output = try? model.prediction(image: bufeada!)
       
        
        salida = output?.classLabel
        defaults.setValue(salida, forKey: "estiloML")
        performSegue(withIdentifier: "toResult", sender: nil)
       
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            let destinationController = segue.destination as! ResultadoMLViewController
            destinationController.estiloMasAccurate = salida
        }
    }
}

