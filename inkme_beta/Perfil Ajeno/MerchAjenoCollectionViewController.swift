//
//  MerchAjenoCollectionViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 2/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "Cell"

class MerchAjenoCollectionViewController: UICollectionViewController {
    let defaults = UserDefaults.standard
    var fotos:[Post] = []
    var usuarioFotoPerfil:String?
    var usuarioNombre:String?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarMerchLista"
        let usuarioId = defaults.integer(forKey: "usuarioIdLista")
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: MerchAjenoResponse.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.articulos) as! [Post]
                collectionView.reloadData()
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarMerchLista"
        let usuarioId = defaults.integer(forKey: "usuarioIdLista")
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: MerchAjenoResponse.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.articulos) as! [Post]
                collectionView.reloadData()
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        
        let url1 = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"
        let usuarioId1 = defaults.integer(forKey: "usuarioIdLista")
        let json1 = ["usuario_id": usuarioId1]
        AF.request(url1, method: .put, parameters: json1 as Parameters, encoding: JSONEncoding.default).responseDecodable (of: UsuarioMerchAjenoResponse.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.usuarioFotoPerfil = (response.value?.usuario?.foto)
                self.usuarioNombre = (response.value?.usuario?.nombre)
                collectionView.reloadData()
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = storyboard?.instantiateViewController(identifier: "PostAjenoViewController") as? PostAjenoViewController
        defaults.set(fotos[indexPath.row].photo, forKey: "urlPostAjeno")
        defaults.set(usuarioFotoPerfil, forKey: "profilePicPostAjeno")
        defaults.set(fotos[indexPath.row].description, forKey: "descriptionPostAjeno")
        defaults.set(usuarioNombre, forKey: "nicknamePostAjeno")
       performSegue(withIdentifier: "itemmerchajenotap", sender: nil)
     
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellmerchajeno", for: indexPath) as? MerchAjenoCollectionViewCell{
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
        if segue.identifier == "itemmerchajenotap"{
            if let indexPaths = collectionView.indexPathsForSelectedItems{
                            collectionView.deselectItem(at: indexPaths[0], animated: false)
                        }
        }

    }
}




