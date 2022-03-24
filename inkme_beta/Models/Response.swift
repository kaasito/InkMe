
import Foundation

struct Response:Decodable {
    let status:Int?
    let usuarios:[User]
}

struct ResponseStatusMsg:Decodable {
    let status:Int?
    let msg:String?
}

struct ResponsePost:Decodable{
    let status:Int?
    let msg:String?
    let posts: [Post]?
}

struct RegisterResponse:Decodable{
    let status: Int?
    let apiToken: String?
    let id:Int?
    
    enum CodingKeys: String, CodingKey {
        case status
        case id
        case apiToken = "api_token"
    }
}

struct LoginPantalla:Decodable{
    let status: Int?
    let msg: String?
    let api_token: String?
    let user: User?
}

struct ResponseGridResultadoML:Decodable {
    let status:Int?
    let post: [Post]?
}

struct ResponseFoto: Decodable{
    let post: Foto?
    let usuario: User?
}

struct ResponseGridPerfilAjeno:Decodable {
    let usuario: UsuarioPropio?
    let status: Int?
}

struct UsuarioMerchAjenoResponse:Decodable{
    let status: Int?
    let usuario: UsuarioMerchAjeno?
}

struct MerchAjenoResponse:Decodable{
    let articulos:[Post?]
    let status:Int?
}

struct PerfilResponse:Decodable {
    let status: Int?
    let usuario: UsuarioPropio?
}

