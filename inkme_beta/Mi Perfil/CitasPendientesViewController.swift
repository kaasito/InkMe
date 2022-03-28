//
//  CitasPendientesTableViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 21/3/22.
//

import UIKit

class CitasPendientesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var noDatesText: UILabel!
    @IBOutlet weak var noDateImage: UIImageView!
    var citas: [Cita]?
    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
       
        PendientesNetWorking.shared.getUser() { arrayCitas in
            self.citas = arrayCitas
            self.tabla.reloadData()
            if self.citas?.count == 0{
                self.noDatesText.isHidden = false
             self.noDateImage.isHidden = false
                self.tabla.isHidden = true
            }else{
                self.noDatesText.isHidden = true
               self.noDateImage.isHidden = true
                self.tabla.isHidden = false
            }
        } failure: { error in
            print(error)
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabla.delegate = self
        self.tabla.dataSource = self
        PendientesNetWorking.shared.getUser() { arrayCitas in
            self.citas = arrayCitas
            self.tabla.reloadData()
            if self.citas?.count == 0{
                self.noDatesText.isHidden = false
             self.noDateImage.isHidden = false
                self.tabla.isHidden = true
            }else{
                self.noDatesText.isHidden = true
               self.noDateImage.isHidden = true
                self.tabla.isHidden = false
            }
        } failure: { error in
            print(error)
        }
        
        self.tabla.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendientesCell", for: indexPath) as! CitasPendientesTableViewCell
        cell.nombre.text = citas![indexPath.row].client_name
        cell.fecha.text = citas![indexPath.row].date
        cell.telefono.text = citas![indexPath.row].client_tlf
        cell.mensaje.text = citas![indexPath.row].comment
        cell.id = citas![indexPath.row].id
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CitasPendientesTableViewCell
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
    }
}

