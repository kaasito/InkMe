//
//  PerfilAjenoCollectionViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 24/2/22.
//

import UIKit

class PerfilAjenoCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imagenCelda: UIImageView!
    func configure(with numberNumber: String){
        let url = URL(string: numberNumber)
        imagenCelda.af.setImage(withURL: url!)
    }
}
