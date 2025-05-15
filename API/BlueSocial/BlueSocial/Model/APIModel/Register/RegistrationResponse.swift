
import Foundation

struct RegistrationResponse : Codable {
	let user_id : Int?
	let name : String?
	let email : String?
	let username : String?
	let image : String?
	let phone : String?
	let height : String?
	let weight : String?
	let gender : String?

	enum CodingKeys: String, CodingKey {

		case user_id = "user_id"
		case name = "name"
		case email = "email"
		case username = "username"
		case image = "image"
		case phone = "phone"
		case height = "height"
		case weight = "weight"
		case gender = "gender"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		username = try values.decodeIfPresent(String.self, forKey: .username)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		height = try values.decodeIfPresent(String.self, forKey: .height)
		weight = try values.decodeIfPresent(String.self, forKey: .weight)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
	}

}
