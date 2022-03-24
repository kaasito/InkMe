
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

struct ResponseGridMiPerfil:Decodable {
    let usuario: User?
    let status: Int?
}


struct MiMerchResponse:Decodable{
    let articulos:[Merch?]
    let status:Int?
}

struct ResponseSubir:Decodable{
    let status: Int?
    let url: String?
}

struct ResponseSubirPost:Decodable {
    let status: Int?
    let msg: String?
    let post_id: Int?
}

struct PerfilResponseEditar:Decodable {
    let status: Int?
    let usuario: UsuarioPropio?
    let msg: String?
}

struct StatsResponse:Decodable {
    let status: Int?
    let total: Int?
    let clientes: Int?
    let tatuadores: Int?
    let top3: [Post]?
}


struct ResponseCita:Decodable{
    let status:Int?
    let citas:[Cita]?
}

struct ResponseBusqueda:Decodable {
    let usuarios:[User]
}
