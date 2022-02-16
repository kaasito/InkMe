import Foundation

struct Response:Decodable {
    let usuarios:[User]
}
struct User:Decodable  {
    let name: String

    
}

struct Post:Decodable  {
    let photo:String
}
