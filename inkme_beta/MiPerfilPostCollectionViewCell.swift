//
//  MiPerfilPostCollectionViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 21/2/22.
//

import UIKit
import AlamofireImage
import Alamofire
class MiPerfilPostCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imagenCelda: UIImageView!
    func configure(with numberNumber: String){
        let url = URL(string: numberNumber)
        imagenCelda.af.setImage(withURL: url!)
    }
}
