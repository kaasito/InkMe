//
//  CitasPendientesTableViewCell.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 21/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

class CitasPendientesTableViewCell: UITableViewCell {

    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var mensaje: UILabel!
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var nombre: UILabel!
    var id:Int?
    let defaults = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
        vista.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func denegadoTapped(_ sender: Any) {
        let token = defaults.string(forKey: "token")
        let url2 = "http://desarrolladorapp.com/inkme/public/api/desactivarCita"
        let json = ["api_token": token, "cita_id": id] as [String : Any]
        AF.request(url2, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: ResponsesPendientes.self) { [self] response in
            print(response)
            
        }
    }
        //FIN REQUEST
        
    
    
    @IBAction func aceptadoTapped(_ sender: Any) {
    }
}


struct ResponsesPendientes:Decodable{
    let status:Int?
    let msg:String?
}
