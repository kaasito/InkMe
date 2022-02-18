import Foundation

struct Response:Decodable {
    let usuarios:[User]
}
struct User:Decodable  {
    let name: String
    let profile_picture: String?
    let location: String
    let styles: String
    let posts:[Post]
    
}

struct Post:Decodable  {
    let photo:String
}
