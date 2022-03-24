import Foundation

struct User:Decodable  {
    let id:Int?
    let name: String?
    let email: String?
    let numtlf: String?
    let profile_picture: String?
    let location: String?
    let styles: String?
    let posts:[Post]?
   
}

struct UsuarioPropio:Decodable{
    let nombre: String?
    let email: String?
    let foto: String?
    let ubicacion: String?
    let styles: String?
    let posts: [Post]?
}
struct UsuarioMerchAjeno:Decodable {
    let foto:String?
    let nombre:String?
}
