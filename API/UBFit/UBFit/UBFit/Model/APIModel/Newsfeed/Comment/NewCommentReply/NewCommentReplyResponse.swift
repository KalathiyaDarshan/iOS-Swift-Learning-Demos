//
//  NewCommentReply.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 14, 2024
//
import Foundation
import SwiftyJSON

class NewCommentReplyResponse{

	var status: Bool?
	var message: String?
	var commentReplyList: NewCommentReply?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
        commentReplyList = NewCommentReply(json["data"])
	}

}
