//
//  ListaViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 18/1/22.
//

import UIKit
import Alamofire
import AlamofireImage

class ListaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListaTableViewCellDelgate {
   
    
    
    
    var nombreUsuario = ""
    var imageURL: String?
    var postId: Int?
    var usuarios: [User] = []
    @IBOutlet weak var barraBusca: UISearchBar!
    @IBOutlet weak var tabla: UITableView!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
        barraBusca.searchTextField.textColor = .white
        
        NetWorkingProvider.shared.getUser() { arrayUsuarios in
            self.usuarios = arrayUsuarios
            self.tabla.reloadData()
        } failure: { error in
            print(error)
        }
        
        if(isAppAlreadyLaunchedOnce() == false){
            self.performSegue(withIdentifier: "AtutorialUsuario", sender: nil)
        }
    }
    
//
//    func didPressFotoPerfil(_ cell: ListaTableViewCell) {
//        nombreUsuario = cell.user!.name
//        performSegue(withIdentifier: "fromnickname", sender: nil)
//    }
    
    func listaTableViewCell(_ cell: ListaTableViewCell, didSelectImageAtIndex index: Int) {
        switch index {
        case 0:
            imageURL = cell.user?.posts![0].photo//patron delegate/proxy
            postId = cell.user?.posts![0].id
            
        case 1:
            imageURL = cell.user?.posts![1].photo//patron delegate/proxy
            postId = cell.user?.posts![1].id
        case 2:
            imageURL = cell.user?.posts![2].photo//patron delegate/proxy
            postId = cell.user?.posts![2].id
        default:
            print("fallo")
        }
        performSegue(withIdentifier: "post", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "post"{
            let sv = segue.destination as! PostViewController
            sv.url = imageURL!
            sv.id = postId!
        }
        if segue.identifier == "fromnickname"{
            let sv = segue.destination as! PerfilAjenoViewController
            sv.nombre = nombreUsuario
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaCell", for: indexPath) as! ListaTableViewCell
        cell.user = usuarios[indexPath.row]
        cell.delegate = self
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
    
    
    
    
}
