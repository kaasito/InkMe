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

    var fotos:[Post] = []
    var ubicacion:String?
    var estilos:String?
    var usuarioId:Int?
    var usuarioNombre:String?
    var usuarioFoto:String?
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioId = defaults.integer(forKey: "usuarioIdLista")
        collectionView.delegate = self
        collectionView.dataSource = self
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarPostPorEstilo"

        let estilo = defaults.string(forKey: "estiloML")
        print("estilo",estilo)
        let json = ["style": estilo]
        AF.request(url, method: .put, parameters: json as Parameters, encoding: JSONEncoding.default).responseDecodable (of: ResponseGridResultadoML.self) { [self] response in
            print(response)
            if (response.value?.status) == 1 {
                self.fotos = (response.value?.post)!
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
       
        
       performSegue(withIdentifier: "itemtapAjeno", sender: nil)
     
     }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "celdagridML", for: indexPath) as? ResultadoMLCollectionViewCell{
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




