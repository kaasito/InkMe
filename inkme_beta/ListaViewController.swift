//
//  ListaViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var barraBusca: UISearchBar!
    @IBOutlet weak var tabla: UITableView!
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaCell", for: indexPath) as! ListaTableViewCell
            cell.profilePic.image = UIImage(named: "harry")
        cell.backgroundColor = .clear
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! ListaTableViewCell
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        //yourSearchBar.searchTextField.textColor = .yourColor
        barraBusca.searchTextField.textColor = .white
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
