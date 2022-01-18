//
//  ListaTableViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit

class ListaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
        vista.layer.cornerRadius = 20
    }
    
   
    
}
