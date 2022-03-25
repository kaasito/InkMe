//
//  ResultadoMLCollectionViewController.swift
//  inkme_beta
//
//  Created by APPS2M on 16/3/22.
//

import UIKit
import Alamofire
import AlamofireImage


class ResultadoMLCollectionViewController: UICollectionViewController {

    var photos:[Post] = []
    var location:String?
    var styles:String?
    var userId:Int?
    var userName:String?
    var userPhoto:String?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = defaults.integer(forKey: "usuarioIdLista")
        collectionView.delegate = self
        collectionView.dataSource = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPostPorEstilo"

        let style = defaults.string(forKey: "estiloML")
        let json = [ "style": style ]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridResultadoML.self) { [self] response in
            if (response.value?.status) == 1 {
                self.photos = (response.value?.post)!
                collectionView.reloadData()
            }else{
                print("an error has occured")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        defaults.set(photos[indexPath.row].id, forKey: "idPostAjeno")
        defaults.set(photos[indexPath.row].photo, forKey: "urlPostAjeno")
        defaults.set(photos[indexPath.row].userProfPic, forKey: "profilePicPostAjeno")
        defaults.set(photos[indexPath.row].description, forKey: "descriptionPostAjeno")
        defaults.set(photos[indexPath.row].userNick, forKey: "nicknamePostAjeno")
       performSegue(withIdentifier: "itemtapML", sender: nil)
     
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdagridML", for: indexPath) as? ResultadoMLCollectionViewCell{
            let url = URL(string: photos[indexPath.row].photo!)

            countryCell.imagenCelda.af.setImage(withURL: url!)
          
            
            cell = countryCell
        }

        return cell
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}




