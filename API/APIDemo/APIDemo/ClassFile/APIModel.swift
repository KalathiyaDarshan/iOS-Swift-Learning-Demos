//
//  APIMode.swift
//  APIDemo
//
//  Created by mac on 24/07/24.
//

import Foundation
import ObjectMapper

// The User class conforms to the Codable protocol
class User: Codable {
    let postID, id: Int
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

//The UserData structure conforms to the SwiftyJson
struct UserData {
    let postID, id: String
    let name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

//The UserDetails structure conforms to the Mappable protocol
struct UserDetails : Mappable {
    var postId : String?
    var id : String?
    var name : String?
    var email : String?
    var body : String?

    init?(map: Map) {
        print("init")
    }

    mutating func mapping(map: Map) {
        print("Mapping")
        postId <- map["postId"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        body <- map["body"]
    }

}


