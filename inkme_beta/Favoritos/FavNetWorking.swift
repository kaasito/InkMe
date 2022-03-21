//
//  FavNetWorking.swift
//  inkme_beta
//
//  Created by Lucas Romero Magaña on 11/3/22.
//

import Foundation
import Alamofire
import AlamofireImage

final class FavNetWorking {
    static let shared = FavNetWorking()
    let defaults = UserDefaults.standard
    var apitoken:String? = ""
    var json: [String: [Int]]?
    let op:[Int] = []
    func getUser(success: @escaping (_ posts: [PostFavoritos]) ->(), failure: @escaping (_ error: String) -> ()){
        let url = "http://desarrolladorapp.com/inkme/public/api/listaDeFavs"
       
        let nums = UserDefaults.standard.array(forKey: "favoritos") as! [Int]? ?? op
            self.json = ["ids": nums]

         
        
        AF.request(url, method: .put, parameters: json,encoding: JSONEncoding.default).responseDecodable (of: ResponseFav.self) { response in
            print("hola",response)
            if  response.value?.status == 1{
                if let posts = response.value?.posts {
                    success(posts)
                }else{
                    print("no se ha podido hacer fetch")
                }
            }
           
        }
    }
    
}


struct ResponseFav:Decodable{
    let status:Int?
    let msg:String?
    let posts: [PostFavoritos]?
}

struct PostFavoritos:Decodable{
    let photo:String?
    let title:String?
    let description:String?
    let id:Int?
}
