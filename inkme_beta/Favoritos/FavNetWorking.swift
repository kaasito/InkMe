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
    var apiToken:String? = ""
    var json: [String: [Int]]?
    let emptyJson:[Int] = []
    func getFavs(success: @escaping (_ posts: [Post]) ->(), failure: @escaping (_ error: String) -> ()){
        let url = "http://desarrolladorapp.com/inkme/public/api/listaDeFavs"
       
        let nums = UserDefaults.standard.array(forKey: "favoritos") as! [Int]? ?? emptyJson
            self.json = ["ids": nums]

         
        
        AF.request(url, method: .put, parameters: json,encoding: JSONEncoding.default).responseDecodable (of: ResponsePost.self) { response in
            if  response.value?.status == 1{
                if let posts = response.value?.posts {
                    success(posts)
                }else{
                    print("There was a mistake")
                }
            }
           
        }
    }
    
}




