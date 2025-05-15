//
//  LoginResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 31, 2024
//
import Foundation
import SwiftyJSON

class LoginResponse {

	let status: Bool?
	let message: String?
    let userInfo: UserInfo?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		userInfo = UserInfo(json["data"])
	}

}
