//
//  ListaViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit
import Alamofire

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var usuarios: [User]?
    @IBOutlet weak var barraBusca: UISearchBar!
    @IBOutlet weak var tabla: UITableView!
    let defaults = UserDefaults.standard
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaCell", for: indexPath) as! ListaTableViewCell
        cell.user = usuarios?[indexPath.row]
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
        self.tabla.delegate = self
        self.tabla.dataSource = self
        NetWorkingProvider.shared.getUser() { arrayUsuarios in
            self.usuarios = arrayUsuarios
            self.tabla.reloadData()
            
        } failure: { error in
            print(error)
        }
        
        
        //yourSearchBar.searchTextField.textColor = .yourColor
        barraBusca.searchTextField.textColor = .white
        // Do any additional setup after loading the view.
        if(isAppAlreadyLaunchedOnce() == false){
            self.performSegue(withIdentifier: "AtutorialUsuario", sender: nil)
            
        }
    }
    
  
    
    
    func isAppAlreadyLaunchedOnce()->Bool{
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
                print("App already launched : \(String(describing: isAppAlreadyLaunchedOnce))")
                return true
            }else{
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                print("App launched first time")
                return false
            }
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
