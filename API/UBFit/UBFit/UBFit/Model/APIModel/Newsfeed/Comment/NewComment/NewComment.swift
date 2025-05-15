//
//  NewComment.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 14, 2024
//
import Foundation
import SwiftyJSON

class NewComment {

	var status: Bool?
	var message: String?
	var commentList: CommentList?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
        commentList = CommentList(json["data"])
	}

}
