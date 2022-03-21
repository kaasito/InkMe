//
//  CitasAceptadasTableViewCell.swift
//  inkme_beta
//
//  Created by APPS2M on 21/3/22.
//

import UIKit

class CitasAceptadasTableViewCell: UITableViewCell {

    
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var comentario: UILabel!
    @IBOutlet weak var telefono: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        vista.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
