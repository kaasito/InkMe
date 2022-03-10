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
  
    
    
    
    var profilepicture = ""
    var estilos = ""
    var ubicacion = ""
    var userId = 0
    var nombreUsuario = ""
    var imageURL: String?
    var postId: Int?
    var usuarios: [User] = []
    @IBOutlet weak var barraBusca: UISearchBar!
    @IBOutlet weak var tabla: UITableView!
    let defaults = UserDefaults.standard
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        let attr = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tabla.addSubview(refreshControl) // not required when using UITableViewController
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
    
   
    @objc func refresh(_ sender: AnyObject) {
        NetWorkingProvider.shared.getUser() { arrayUsuarios in
            self.usuarios = arrayUsuarios
            self.tabla.reloadData()
        } failure: { error in
            print(error)
        }
        tabla.reloadData()
        refreshControl.endRefreshing()
    }
    
    func callSegueFromCell(_ cell: ListaTableViewCell, didSelectNickName index: Bool) {
        if index == true{
            
            
            userId = (cell.user?.id)!
            defaults.set(userId, forKey: "usuarioIdLista")
            ubicacion = (cell.user?.location)!
            estilos = (cell.user?.styles)!
            profilepicture = (cell.user?.profile_picture) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg"
            nombreUsuario = (cell.user?.name)!
            performSegue(withIdentifier: "fromnickname", sender: nil)
        }

    }
 
    func didPressFotoPerfil(_ cell: ListaTableViewCell, didSelecProfilePic index: Bool) {
        if index == true{
            
            
            userId = (cell.user?.id)!
            defaults.set(userId, forKey: "usuarioIdLista")
            ubicacion = (cell.user?.location)!
            estilos = (cell.user?.styles)!
            profilepicture = (cell.user?.profile_picture) ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg"
            nombreUsuario = (cell.user?.name)!
            performSegue(withIdentifier: "fromnickname", sender: nil)
        }
    }
    
    func listaTableViewCell(_ cell: ListaTableViewCell, didSelectImageAtIndex index: Int) {
        switch index {
        case 0:
            imageURL = cell.user?.posts![0].photo ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg"//patron delegate/proxy
            postId = cell.user?.posts![0].id
            
        case 1:
            imageURL = cell.user?.posts![1].photo ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg"//patron delegate/proxy
            postId = cell.user?.posts![1].id
        case 2:
            imageURL = cell.user?.posts![2].photo ?? "https://fundaciongaem.org/wp-content/uploads/2016/05/no-foto.jpg"//patron delegate/proxy
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
            sv.id = userId
            sv.imagenPerfilString = profilepicture
            sv.nombre = nombreUsuario
            sv.estilo = estilos
            sv.ubicacion = ubicacion
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
