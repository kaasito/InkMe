//
//  ListaFavoritossViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 14/3/22.
//

import UIKit
import Alamofire
import AlamofireImage


class ListaFavoritosViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, FavsTableViewCellDelgate {
    @IBOutlet weak var emptyListIlustration: UIImageView!
    @IBOutlet weak var emptyListText: UILabel!
    var id = 0
    var cellPostUrl:String?
    func didPressProfilePicture(_ cell: FavsTableViewCell, didSelecProfilePic index: Bool) {
        if index == true{
            id = (cell.post?.id)!
            cellPostUrl = cell.post?.photo
            performSegue(withIdentifier: "fromfavs", sender: nil)
        }
    }
    
    
    var posts: [Post]?
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
       
        FavNetWorking.shared.getFavs() { arrayPost in
            self.posts = arrayPost
            if self.posts?.count == 0{
                self.emptyListText.isHidden = false
                self.emptyListIlustration.isHidden = false
                self.table.isHidden = true
            }else{
                self.emptyListText.isHidden = true
                self.emptyListIlustration.isHidden = true
                self.table.isHidden = false
            }
            self.table.reloadData()
        } failure: { error in
            print(error)
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.table.delegate = self
        self.table.dataSource = self
        FavNetWorking.shared.getFavs() { arrayPost in
            self.posts = arrayPost
            if self.posts?.count == 0{
                self.emptyListText.isHidden = false
                self.emptyListIlustration.isHidden = false
                self.table.isHidden = true
            }else{
                self.emptyListText.isHidden = true
                self.emptyListIlustration.isHidden = true
                self.table.isHidden = false
            }
            self.table.reloadData()
        } failure: { error in
            print(error)
        }
        
        self.table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromfavs"{
            let sv = segue.destination as! PostViewController
            sv.id = id
            sv.url = cellPostUrl!
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

}
