//
//  NewsfeedResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 01, 2024
//
import Foundation
import SwiftyJSON

class NewsfeedResponse {

	let status: Bool?
	let message: String?
	let totalPageIndex: Int?
	let newsFeedPost: [NewsFeedPost]?

	init(_ json: JSON) {
		status = json["status"].boolValue
		message = json["message"].stringValue
		totalPageIndex = json["totalPageIndex"].intValue
        newsFeedPost = json["data"].arrayValue.map { UBFit.NewsFeedPost($0) }
	}

}
