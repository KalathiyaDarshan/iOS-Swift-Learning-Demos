//
//  UserAnswers.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 31, 2024
//
import Foundation
import SwiftyJSON

class UserAnswers {

	let questionId: String?
	let questionTitle: String?
	let description: String?
	let answerOption: [String]?
	let answerId: String?
	let userAnswer: String?
	let userAnswer2: String?
	let answerDescription: String?

	init(_ json: JSON) {
		questionId = json["question_id"].stringValue
		questionTitle = json["question_title"].stringValue
		description = json["description"].stringValue
		answerOption = json["answer_option"].arrayValue.map { $0.stringValue }
		answerId = json["answer_id"].stringValue
		userAnswer = json["user_answer"].stringValue
		userAnswer2 = json["user_answer2"].stringValue
		answerDescription = json["answer_description"].stringValue
	}

}
