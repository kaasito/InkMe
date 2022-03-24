//
//  ListaFavoritossViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 14/3/22.
//

import UIKit
import Alamofire
import AlamofireImage


class ListaFavoritossViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, FavsTableViewCellDelgate {
    @IBOutlet weak var imagenIlu: UIImageView!
    @IBOutlet weak var textovacio: UILabel!
    var id = 0
    var url1:String?
    func didPressFotoPerfil(_ cell: FavsTableViewCell, didSelecProfilePic index: Bool) {
        if index == true{
            
            
            id = (cell.post?.id)!
            url1 = cell.post?.photo
            performSegue(withIdentifier: "fromfavs", sender: nil)
        }
    }
    
    
    var posts: [Post]?
    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabla.delegate = self
        self.tabla.dataSource = self
       
        FavNetWorking.shared.getUser() { arrayPost in
            self.posts = arrayPost
            if self.posts?.count == 0{
                self.textovacio.isHidden = false
                self.imagenIlu.isHidden = false
                self.tabla.isHidden = true
            }else{
                self.textovacio.isHidden = true
                self.imagenIlu.isHidden = true
                self.tabla.isHidden = false
            }
            self.tabla.reloadData()
        } failure: { error in
            print(error)
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabla.delegate = self
        self.tabla.dataSource = self
        FavNetWorking.shared.getUser() { arrayPost in
            self.posts = arrayPost
            if self.posts?.count == 0{
                self.textovacio.isHidden = false
                self.imagenIlu.isHidden = false
                self.tabla.isHidden = true
            }else{
                self.textovacio.isHidden = true
                self.imagenIlu.isHidden = true
                self.tabla.isHidden = false
            }
            self.tabla.reloadData()
        } failure: { error in
            print(error)
        }
        
        self.tabla.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromfavs"{
            let sv = segue.destination as! PostViewController
            sv.id = id
            sv.url = url1!
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavsCell", for: indexPath) as! FavsTableViewCell
        cell.post = posts![indexPath.row]
        cell.delegate = self
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! FavsTableViewCell
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
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
