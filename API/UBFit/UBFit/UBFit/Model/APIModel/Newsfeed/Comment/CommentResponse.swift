//
//  CommentResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 02, 2024
//
import Foundation
import SwiftyJSON

class CommentResponse {

	let status: Bool?
	let message: String?
	let totalPageIndex: Int?
	let CommentList: [CommentList]?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		totalPageIndex = json["totalPageIndex"].intValue
        CommentList = json["data"].arrayValue.map { UBFit.CommentList($0) }
	}

}
