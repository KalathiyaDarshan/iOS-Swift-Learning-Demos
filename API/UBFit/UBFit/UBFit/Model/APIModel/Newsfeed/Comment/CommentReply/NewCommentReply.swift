//
//  CommentReplyList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 09, 2024
//
import Foundation
import SwiftyJSON

class NewCommentReply {

	let commentId: String?
	let userId: String?
	let slug: String?
	let username: String?
	let fullName: String?
	let replyUserName: String?
	let img: String?
	let userComments: String?
	let createdAt: String?
	var isLike: Bool?
	var totalLikes: Int?
	let time: String?
    var btnMore: Bool = true

	init(_ json: JSON) {
		commentId = json["comment_id"].stringValue
		userId = json["user_id"].stringValue
		slug = json["slug"].stringValue
		username = json["username"].stringValue
		fullName = json["full_name"].stringValue
		replyUserName = json["reply_user_name"].stringValue
		img = json["img"].stringValue
		userComments = json["user_comments"].stringValue
		createdAt = json["created_at"].stringValue
		isLike = json["isLike"].boolValue
		totalLikes = json["total_likes"].intValue
		time = json["time"].stringValue
	}

}
