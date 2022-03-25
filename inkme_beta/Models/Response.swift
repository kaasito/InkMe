import Foundation

struct Response:Decodable {
    let status:Int?
    let users:[User]
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
    let user: User?
}

struct ResponseGridPerfilAjeno:Decodable {
    let user: User?
    let status: Int?
}

struct UsuarioMerchAjenoResponse:Decodable{
    let status: Int?
    let user: User?
}

struct MerchAjenoResponse:Decodable{
    let articles:[Post?]
    let status:Int?
}

struct PerfilResponse:Decodable {
    let status: Int?
    let user: User?
}

struct ResponseGridMiPerfil:Decodable {
    let user: User?
    let status: Int?
}


struct MiMerchResponse:Decodable{
    let articles:[Merch?]
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
    let user: User?
    let msg: String?
}

struct StatsResponse:Decodable {
    let status: Int?
    let total: Int?
    let clients: Int?
    let tattooist: Int?
    let top3: [Post]?
}


struct ResponseCita:Decodable{
    let status:Int?
    let citas:[Cita]?
}
