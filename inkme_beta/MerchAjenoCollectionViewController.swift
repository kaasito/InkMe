//
//  MerchAjenoCollectionViewController.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 2/3/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class MerchAjenoCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPerfil"

//        print("el user bro",usuarioId)
//        let json = ["usuario_id": usuarioId]
//        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridPerfilAjeno.self) { [self] response in
//            print(response)
//            if (response.value?.status) == 1 {
//                self.fotos = (response.value?.usuario?.posts)!
//                collectionView.reloadData()
//            }else{
//                print("no se ha podido hacer fetch")
//            }
//        }
    }

    
}
