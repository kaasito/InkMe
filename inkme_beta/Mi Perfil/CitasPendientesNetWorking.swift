import Foundation
import Alamofire
import AlamofireImage

final class PendientesNetWorking {
    static let shared = PendientesNetWorking()
    let defaults = UserDefaults.standard
    
    func getUser(success: @escaping (_ citas: [CitasPendientes]) ->(), failure: @escaping (_ error: String) -> ()){
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarCitasPendientes"
        
        let api_token = defaults.string(forKey: "token")
        let json = ["api_token": api_token]
        
        
        
        AF.request(url, method: .put, parameters: json,encoding: JSONEncoding.default).responseDecodable (of: ResponsePendientes.self) { response in
            print("hola",response)
            if  response.value?.status == 1{
                if let citas = response.value?.citas {
                    success(citas)
                }else{
                    print("no se ha podido hacer fetch")
                }
            }
            
        }
    }
    
    
    
    
    
}

struct ResponsePendientes:Decodable{
    let status:Int?
    let citas:[CitasPendientes]?
}

struct CitasPendientes:Decodable{
    var id:Int?
    let date:String?
    let client_tlf:String?
    let client_name:String?
    let comment:String?
    let state:String?
}
