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
    var ubicacion:String?
    var estilos:String?
    var usuarioId:Int?
    var usuarioNombre:String?
    var usuarioFoto:String?
    var jsonn: [String:Any]?
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
                self.ubicacion = (response.value?.usuario?.ubicacion)!
                self.usuarioNombre = (response.value?.usuario?.nombre)!
                self.estilos = (response.value?.usuario?.styles)!
                self.usuarioFoto = (response.value?.usuario?.foto)!
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
        defaults.set(fotos[indexPath.row].id, forKey: "idPostAjeno")
        defaults.set(fotos[indexPath.row].title, forKey: "titlePostAjeno")
        defaults.set(fotos[indexPath.row].description, forKey: "descriptionPostAjeno")
        defaults.set(usuarioNombre, forKey: "nicknamePostAjeno")
        defaults.set(usuarioFoto, forKey: "profilePicPostAjeno")
        defaults.set(estilos, forKey: "stylesPostAjeno")
        defaults.set(ubicacion, forKey: "locationPostAjeno")
        defaults.set(usuarioId, forKey: "usuarioAjeno")
        let postiD = defaults.integer(forKey: "idPostAjeno")
        let url = "http://desarrolladorapp.com/inkme/public/api/sumarViewPost"
        let apiiitoken = defaults.string(forKey: "token")
        
        if apiiitoken == nil{
            jsonn = ["api_token": "", "post_id": postiD]
        }else{
            jsonn = ["api_token": apiiitoken!,"post_id": postiD]
        }
        
        AF.request(url, method: .put, parameters: jsonn,encoding: JSONEncoding.default).responseDecodable (of: ResponsePrueba.self) { response in
            print("ashjagsjhags",response)
        }
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
    let nombre:String?
    let foto:String?
    let styles:String?
    let ubicacion:String?
}

struct PostGridAjeno:Decodable {
    let photo:String?
    let id:Int?
    let title:String?
    let description:String?
}
