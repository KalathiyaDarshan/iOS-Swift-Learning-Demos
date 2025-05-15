//
//  APIResponse.swift
//  podinstall
//
//  Created by mac on 23/07/24.
//

import Foundation
import ObjectMapper

struct UserData: Codable {
    let name: String
    let email: String
    let id: String
    let joining: String
}

// Model for the outer response
struct APIResponse: Codable {
    let errorMessage: String
    let data: UserData
}

struct UserDataMappable: Mappable {
    var name: String = ""
    var email: String = ""
    var id: String = ""
    var joining: String = ""

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        name    <- map["name"]
        email   <- map["email"]
        id      <- map["id"]
        joining <- map["joining"]
    }
}

// Model for the outer response
struct APIResponseMappable: Mappable {
    var errorMessage: String = ""
    var data: UserDataMappable?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        errorMessage <- map["errorMessage"]
        data         <- map["data"]
    }
}
