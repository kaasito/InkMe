import Foundation
import Alamofire

final class NetWorkingProvider{
    static let shared = NetWorkingProvider()
    
    func getUser(success: @escaping (_ users: [User]) ->(), failure: @escaping (_ error: String) -> ()){
        let url = "http://localhost:8888/inkme/public/api/fetchFeed"
        
        
        
        
        AF.request(url, method: .put).responseDecodable (of: Response.self) { response in
            print(response)
            if let users = response.value?.usuarios {
                success(users)
                for user in users {
                    print(user.name)
                }
            }else{
                print("no se ha podido hacer fetch")
            }
        }
    }
    
  
}





