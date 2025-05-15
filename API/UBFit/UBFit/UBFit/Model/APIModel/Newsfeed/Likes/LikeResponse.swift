//
//  LikeResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 05, 2024
//
import Foundation
import SwiftyJSON

class LikeResponse {

	let status: Bool?
	let message: String?
	let isLike: Bool?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		isLike = json["isLike"].boolValue
	}
}
