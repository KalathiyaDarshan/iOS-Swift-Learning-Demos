//
//  newsFeedPost.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 01, 2024
//
import Foundation
import SwiftyJSON

class NewsFeedPost {

	let feedId: String?
	let userId: String?
	let isVerified: Int?
	let fullName: String?
	let img: String?
	let newsfeedType: String?
	let slug: String?
	let description: String?
	let createdAt: String?
	let images: [String]?
	let video: String?
	var likes: String?
	var comments: String?
	let time: String?
	var isLike: Bool?
	let hId: String?
	var isFollow: Bool?

	init(_ json: JSON) {
		feedId = json["feed_id"].stringValue
		userId = json["user_id"].stringValue
		isVerified = json["is_verified"].intValue
		fullName = json["full_name"].stringValue
		img = json["img"].stringValue
		newsfeedType = json["newsfeed_type"].stringValue
		slug = json["slug"].stringValue
		description = json["description"].stringValue
		createdAt = json["created_at"].stringValue
        images = json["images"].arrayValue.map { $0.stringValue }
		video = json["video"].stringValue
		likes = json["likes"].stringValue
		comments = json["comments"].stringValue
		time = json["time"].stringValue
		isLike = json["isLike"].boolValue
		hId = json["h_id"].stringValue
		isFollow = json["isFollow"].boolValue
	}

}
