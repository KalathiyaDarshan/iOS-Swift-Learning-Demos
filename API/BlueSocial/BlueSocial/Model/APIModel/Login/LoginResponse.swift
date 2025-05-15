/* 
Copyright (c) 2024 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct LoginResponse : Codable {
	let user_id : String?
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
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
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
