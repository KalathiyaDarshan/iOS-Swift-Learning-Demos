//
//  FollowResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 21, 2024
//
import Foundation
import SwiftyJSON

class FollowResponse {

	var status: Bool?
	var message: String?
	var isFollow: Bool?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		isFollow = json["isFollow"].boolValue
	}

}