//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 31, 2024
//
import Foundation
import SwiftyJSON

class UserInfo {

	let id: String?
	let authToken: String?
	let fullName: String?
	let firstName: String?
	let lastName: String?
	let username: String?
	let zipCode: String?
	let img: String?
	let slug: String?
	let instagram: Any?
	let trainerId: Any?
	let bio: Any?
	let lat: Any?
	let lng: Any?
	let isTrainer: String?
	let specialities: String?
	let availabilityHours: [Any]?
	let trainerStatus: Any?
	let email: String?
	let phone: String?
	let countryCode: String?
	let countryShortName: Any?
	let age: String?
	let weight: String?
	let heightFeet: String?
	let heightInches: String?
	let gender: String?
	let equipment: Any?
	let location: Any?
	let address: Any?
	let city: Any?
	let state: Any?
	let idImg: Any?
	let certificates: Any?
	let cprCertificate: Any?
	let certExpDate: Any?
	let idCardExp: Any?
	let cprCertExp: Any?
	let plicExp: Any?
	let yearsOfExp: Any?
	let empHistory: Any?
	let empHistoryFrom: Any?
	let empHistoryTo: Any?
	let empHistoryLeaveReason: Any?
	let curWork: Any?
	let bgCheck: Any?
	let transportation: Any?
	let bilingual: Any?
	let lang1: Any?
	let lang2: Any?
	let legalUsRes: Any?
	let needSponsorship: Any?
	let healthConditions: Any?
	let references: Any?
	let resume: Any?
	let plic: Any?
	let following: Int?
	let favorites: Int?
	let credits: Int?
	let userAnswers: [UserAnswers]?
	let answerFlag: Bool?
	let profileUrl: String?
	let posts: [Any]?
	let activeSession: String?
	let completedSession: String?
	let isCancel: Any?
	let isAbleCall: String?
	let isActiveProgram: Bool?

	init(_ json: JSON) {
		id = json["id"].stringValue
		authToken = json["auth_token"].stringValue
		fullName = json["full_name"].stringValue
		firstName = json["first_name"].stringValue
		lastName = json["last_name"].stringValue
		username = json["username"].stringValue
		zipCode = json["zip_code"].stringValue
		img = json["img"].stringValue
		slug = json["slug"].stringValue
		instagram = json["instagram"]
		trainerId = json["trainer_id"]
		bio = json["bio"]
		lat = json["lat"]
		lng = json["lng"]
		isTrainer = json["is_trainer"].stringValue
		specialities = json["specialities"].stringValue
		availabilityHours = json["availability_hours"].arrayValue.map { $0 }
		trainerStatus = json["trainer_status"]
		email = json["email"].stringValue
		phone = json["phone"].stringValue
		countryCode = json["country_code"].stringValue
		countryShortName = json["country_short_name"]
		age = json["age"].stringValue
		weight = json["weight"].stringValue
		heightFeet = json["height_feet"].stringValue
		heightInches = json["height_inches"].stringValue
		gender = json["gender"].stringValue
		equipment = json["equipment"]
		location = json["location"]
		address = json["address"]
		city = json["city"]
		state = json["state"]
		idImg = json["id_img"]
		certificates = json["certificates"]
		cprCertificate = json["cpr_certificate"]
		certExpDate = json["cert_exp_date"]
		idCardExp = json["id_card_exp"]
		cprCertExp = json["cpr_cert_exp"]
		plicExp = json["plic_exp"]
		yearsOfExp = json["years_of_exp"]
		empHistory = json["emp_history"]
		empHistoryFrom = json["emp_history_from"]
		empHistoryTo = json["emp_history_to"]
		empHistoryLeaveReason = json["emp_history_leave_reason"]
		curWork = json["cur_work"]
		bgCheck = json["bg_check"]
		transportation = json["transportation"]
		bilingual = json["bilingual"]
		lang1 = json["lang_1"]
		lang2 = json["lang_2"]
		legalUsRes = json["legal_us_res"]
		needSponsorship = json["need_sponsorship"]
		healthConditions = json["health_conditions"]
		references = json["references"]
		resume = json["resume"]
		plic = json["plic"]
		following = json["following"].intValue
		favorites = json["favorites"].intValue
		credits = json["credits"].intValue
		userAnswers = json["user_answers"].arrayValue.map { UserAnswers($0) }
		answerFlag = json["answer_flag"].boolValue
		profileUrl = json["profile_url"].stringValue
		posts = json["posts"].arrayValue.map { $0 }
		activeSession = json["active_session"].stringValue
		completedSession = json["completed_session"].stringValue
		isCancel = json["isCancel"]
		isAbleCall = json["is_able_call"].stringValue
		isActiveProgram = json["is_active_program"].boolValue
	}

}
