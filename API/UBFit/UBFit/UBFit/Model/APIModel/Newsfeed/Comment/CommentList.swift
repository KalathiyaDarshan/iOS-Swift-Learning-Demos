//
//  CommentList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 02, 2024
//
import Foundation
import SwiftyJSON

class CommentList {

	let commentId: String?
	let userId: String?
	let slug: String?
	let username: String?
	let fullName: String?
	let img: String?
	let userComments: String?
	let createdAt: String?
	var isLike: Bool?
	var totalLikes: Int?
	var totalReplyComments: Int?
	let time: String?
    var replyPageIndex: Int = 0
    var totalPageIndex: Int = 0
    var currentReplyCount: Int = 0
    var btnMore: Bool = true
    var arrCommentReply: [NewCommentReply] = []

	init(_ json: JSON) {
		commentId = json["comment_id"].stringValue
		userId = json["user_id"].stringValue
		slug = json["slug"].stringValue
		username = json["username"].stringValue
		fullName = json["full_name"].stringValue
		img = json["img"].stringValue
		userComments = json["user_comments"].stringValue
		createdAt = json["created_at"].stringValue
		isLike = json["isLike"].boolValue
		totalLikes = json["total_likes"].intValue
        totalReplyComments = json["total_reply_comments"].intValue
		time = json["time"].stringValue
	}
}
