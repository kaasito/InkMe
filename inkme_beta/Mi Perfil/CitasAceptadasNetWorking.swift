import Foundation
import Alamofire
import AlamofireImage

final class AceptadasNetWorking {
    static let shared = AceptadasNetWorking()
    let defaults = UserDefaults.standard
    
    func getUser(success: @escaping (_ citas: [CitasActvas]) ->(), failure: @escaping (_ error: String) -> ()){
        let url = "http://desarrolladorapp.com/inkme/public/api/cargarCitasActivas"
        
        let api_token = defaults.string(forKey: "token")
        let json = ["api_token": api_token]
        
        
        
        AF.request(url, method: .put, parameters: json,encoding: JSONEncoding.default).responseDecodable (of: ResponseActivos.self) { response in
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
    
    
    
    
    struct ResponseActivos:Decodable{
        let status:Int?
        let citas:[CitasActvas]?
    }
    
    struct CitasActvas:Decodable{
        let date:String?
        let client_tlf:String?
        let client_name:String?
        let comment:String?
        let state:String?
    }
    
}
