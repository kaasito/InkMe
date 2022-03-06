//
//  PerfilAjenoCollectionViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 24/2/22.
//

import UIKit
import Alamofire
import AlamofireImage
private let reuseIdentifier = "Cell"

class PerfilAjenoCollectionViewController: UICollectionViewController {
    var fotos:[PostGridAjeno] = []
    var usuarioId:Int?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioId = defaults.integer(forKey: "usuarioIdLista")
        collectionView.delegate = self
        collectionView.dataSource = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"

        print("el user bro",usuarioId!)
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridPerfilAjeno.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.usuario?.posts)!
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
       
        defaults.set(fotos[indexPath.row].photo, forKey: "urlPostAjeno")
       performSegue(withIdentifier: "itemtapAjeno", sender: nil)
     
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdagridAjeno", for: indexPath) as? PerfilAjenoCollectionViewCell{
            let url = URL(string: fotos[indexPath.row].photo!)

            countryCell.imagenCelda.af.setImage(withURL: url!)
            cell = countryCell
        }

        return cell
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


struct ResponseGridPerfilAjeno:Decodable {
    let usuario: UsuarioGridAjeno?
    let status: Int?
}

struct UsuarioGridAjeno:Decodable {
    let posts: [PostGridAjeno]?
}

struct PostGridAjeno:Decodable {
    let photo:String?
}
