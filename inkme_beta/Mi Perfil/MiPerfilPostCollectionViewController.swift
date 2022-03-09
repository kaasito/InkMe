//
//  MiPerfilPostCollectionViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 21/2/22.
//

import UIKit
import AlamofireImage
import Alamofire



class MiPerfilPostCollectionViewController: UICollectionViewController {
    @IBOutlet var collectionViewPost: UICollectionView!
    var vSpinner : UIView?
    var fotos:[PostMiGrid] = []
    let datasource = ["1","2","3","4","5","6"]
    let defaults = UserDefaults.standard
    var imagenPasar:UIImage?
    let refreshControl = UIRefreshControl()
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"
        let usuarioId = defaults.integer(forKey: "id")
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridMiPerfil.self) { [self] response in
            print(response)
           
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.usuario?.posts)!
                collectionView.reloadData()
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView.reloadData()
    }
    
   */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0);
        let attr = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl) // not required when using UITableViewController
        collectionView.dataSource = self
        collectionView.delegate = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"
        let usuarioId = defaults.integer(forKey: "id")
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridMiPerfil.self) { [self] response in
            print(response)
            
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.usuario?.posts)!
                collectionView.reloadData()
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        collectionView.dataSource = self
        collectionView.delegate = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"
        let usuarioId = defaults.integer(forKey: "id")
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridMiPerfil.self) { [self] response in
            print(response)
            
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.usuario?.posts)!
                collectionView.reloadData()
                
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "MiPostViewController") as? MiPostViewController
        defaults.set(fotos[indexPath.row].photo, forKey: "urlMiPerfil")
        defaults.set(fotos[indexPath.row].id, forKey: "idMiPerfil")
       performSegue(withIdentifier: "itemtap", sender: nil)
     
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdagrid", for: indexPath) as? MiPerfilPostCollectionViewCell{
            let url = URL(string: fotos[indexPath.row].photo!)
            
            countryCell.imagenCelda.af.setImage(withURL: url!)
            cell = countryCell
        }
        
        return cell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemtap"{
            if let indexPaths = collectionView.indexPathsForSelectedItems{
                            let destinationController = segue.destination as! MiPostViewController
//                            destinationController.imagenSeleccionada.image = imagenPasar
                            collectionView.deselectItem(at: indexPaths[0], animated: false)
                        }
        }

    }
}


struct ResponseGridMiPerfil:Decodable {
    let usuario: UsuarioMiGrid?
    let status: Int?
}

struct UsuarioMiGrid:Decodable {
    let posts: [PostMiGrid]?
}

struct PostMiGrid:Decodable {
    let photo:String?
    let id: Int?
}


extension MiPerfilPostCollectionViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async { [self] in
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
