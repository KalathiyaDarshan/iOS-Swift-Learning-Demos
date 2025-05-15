//
//  CommentReply.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2024
//
import Foundation
import SwiftyJSON

class CommentReply {

	let status: Bool?
	let message: String?
	let totalPageIndex: Int?
	let CommentReplyList: [NewCommentReply]?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		totalPageIndex = json["totalPageIndex"].intValue
        CommentReplyList = json["data"].arrayValue.map { UBFit.NewCommentReply($0) }
	}

}
