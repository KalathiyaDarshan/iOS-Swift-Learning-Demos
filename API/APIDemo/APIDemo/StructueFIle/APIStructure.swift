//
//  APIStructure.swift
//  APIDemo
//
//  Created by mac on 24/07/24.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

struct APIService {
    
    // Fetches posts from the given URL using Codable for JSON parsing
    static func fetchPostsUsingCodable(url: String, method: HTTPMethod, completion: @escaping (Result<[User], AFError>) -> Void) {
        
        AF.request(url, method: method, encoding: JSONEncoding.default, headers: [:])
            
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            
                            // Decode data into [User] array
                            let users = try JSONDecoder().decode([User].self, from: data)
                            completion(.success(users))
                            
                        } catch {
                            
                            // Handle JSON decoding error
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                    
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    // Fetches posts from the given URL using SwiftyJSON for JSON parsing
    static func fetchPostsUsingSwiftJson(url: String, method: HTTPMethod, completion: @escaping (Result<[UserData], AFError>) -> Void) {
        
        AF.request(url, method: method, headers: [:])
            
            .responseData { response in
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            var users: [UserData] = []
                            
                            for userJSON in json.arrayValue {
                                
                                let user = UserData(
                                    postID: userJSON["postId"].stringValue,
                                    id: userJSON["id"].stringValue,
                                    name: userJSON["name"].stringValue,
                                    email: userJSON["email"].stringValue,
                                    body: userJSON["body"].stringValue
                                )
                                users.append(user)
                            }
                            completion(.success(users))
                            
                        } catch {
                            // Handle JSON decoding error
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                   
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    // Fetches posts from the given URL using ObjectMapper for JSON parsing
    static func fetchPostsUsingObjecMapper(url: String, method: HTTPMethod, completion: @escaping (Result<[UserDetails], AFError>) -> Void) {
        
        AF.request(url, method: method, headers: [:])
            
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            
                            if let dataArray = json.arrayObject  as? [[String: Any]] {
                                
                                let users = Mapper<UserDetails>().mapArray(JSONArray: dataArray)
                                completion(.success(users))
                            }
                            
                        } catch {
                            // Handle JSON decoding error
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                    
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
}
