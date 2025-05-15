//
//  LikeList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2024
//
import Foundation
import SwiftyJSON

class LikeList {

	let userId: String?
	let slug: String?
	let username: String?
	let fullName: String?
	let img: String?
	var isFollow: Bool?

	init(_ json: JSON) {
		userId = json["user_id"].stringValue
		slug = json["slug"].stringValue
		username = json["username"].stringValue
		fullName = json["full_name"].stringValue
		img = json["img"].stringValue
		isFollow = json["isFollow"].boolValue
	}

}
