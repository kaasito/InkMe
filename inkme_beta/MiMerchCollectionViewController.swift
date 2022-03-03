//
//  MiMerchCollectionViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 3/3/22.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class MiMerchCollectionViewController: UICollectionViewController {
    let defaults = UserDefaults.standard
    var fotos:[MiMerch] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarMerchLista"
       
        let usuarioId = defaults.integer(forKey: "id")
    
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: MiMerchResponse.self) { [self] response in
            print("response merch",response)
            if (response.value?.status) == 1 {
                
                self.fotos = (response.value?.articulos) as! [MiMerch]
                collectionView.reloadData()
            }else{
                print("no se ha podido hacer fetch")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarMerchLista"
        
        let usuarioId = defaults.integer(forKey: "id")
    
        let json = ["usuario_id": usuarioId]
        AF.request(url, method: .put, parameters: json, encoding: JSONEncoding.default).responseDecodable (of: MiMerchResponse.self) { [self] response in
            print("response merch",response)
            if (response.value?.status) == 1 {
                
                self.fotos = (response.value?.articulos) as! [MiMerch]
                collectionView.reloadData()
            }else{
                print("no se ha podido hacer fetch")
            }
        }
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView.reloadData()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotos.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "MiPostViewController") as? MiPostViewController
        defaults.set(fotos[indexPath.row].photo, forKey: "urlMiPerfil")
       performSegue(withIdentifier: "itemmerchtap", sender: nil)
     
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellmerchmiperfil", for: indexPath) as? MiMerchCollectionViewCell{
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




struct MiMerchResponse:Decodable{
    let articulos:[MiMerch?]
    let status:Int?
}

struct MiMerch:Decodable{
    let photo:String?
}
