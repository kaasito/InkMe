import Foundation

struct Response:Decodable {
    let usuarios:[User]
}
struct User:Decodable  {
    let name: String?
    let profile_picture: String?
    let location: String?
    let styles: String?
    let posts:[Post]?
    let id:Int?
    
}

struct Post:Decodable  {
    let photo:String?
    let id: Int?
}
