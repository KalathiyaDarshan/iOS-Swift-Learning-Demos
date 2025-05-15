//
//  LikeListReply.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2024
//
import Foundation
import SwiftyJSON

class LikeListReply {

	let status: Bool?
	let message: String?
	let totalPageIndex: Int?
	let LikeList: [LikeList]?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		totalPageIndex = json["totalPageIndex"].intValue
        LikeList = json["data"].arrayValue.map { UBFit.LikeList($0) }
	}

}
