import Foundation
import Alamofire

final class NetWorkingProvider{
    static let shared = NetWorkingProvider()
    let defaults = UserDefaults.standard
    var apitoken:String? = ""
    var json: [String: String]?
    func getUser(success: @escaping (_ users: [User]) ->(), failure: @escaping (_ error: String) -> ()){
        let url = "http://desarrolladorapp.com/inkme/public/api/fetchFeed"
        apitoken = defaults.string(forKey: "token")
        
        if apitoken == nil{
            self.json = ["api_token": ""]
        }else{
            self.json = ["api_token": apitoken!]
        }
        
        AF.request(url, method: .put, parameters: json,encoding: JSONEncoding.default).responseDecodable (of: Response.self) { response in
            print(response)
            if let users = response.value?.usuarios {
                success(users)
                for user in users {
                    print("nombre",user.name)
                   
                }
            }else{
                print("no se ha podido hacer fetch")
            }
        }
    }
    
  
}





