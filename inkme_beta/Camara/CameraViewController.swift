//
//  CamaraViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit
import CoreML

class CameraViewController: UIViewController {
    
    let model = TattooClasifier_1()
    var modelBestResult:String?
    let defaults = UserDefaults.standard
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var selectedImage: UIImageView!
    @IBOutlet weak var selectResourceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func selectResourcePressed(_ sender: Any) {
        
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
    
   
    
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
       
        if selectedImage.image == nil{
            let alert = UIAlertController(title: "Error", message: "Tienes que subir una foto para realizar una busqueda", preferredStyle: .alert)
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
        }
        
        let image = selectedImage.image
        let targetSize = CGSize(width: 299, height: 299)

        // Compute the scaling ratio for the width and height separately
        let widthScaleRatio = targetSize.width / image!.size.width
        let heightScaleRatio = targetSize.height / image!.size.height

        // To keep the aspect ratio, scale by the smaller scaling ratio
        let scaleFactor = min(widthScaleRatio, heightScaleRatio)

        // Multiply the original image’s dimensions by the scale factor
        // to determine the scaled image size that preserves aspect ratio
        _ = CGSize(
            width: image!.size.width * scaleFactor,
            height: image!.size.height * scaleFactor
        )
        
        let bufeada = selectedImage.image?.toBuffer()
        let output = try? model.prediction(image: bufeada!)
       
        
        modelBestResult = output?.classLabel
        defaults.setValue(modelBestResult, forKey: "estiloML")
        performSegue(withIdentifier: "toResult", sender: nil)
       
        
    }
}


extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
       
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        selectedImage.image = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            let destinationController = segue.destination as! ResultadoMLViewController
            destinationController.estiloMasAccurate = modelBestResult
        }
    }
}

