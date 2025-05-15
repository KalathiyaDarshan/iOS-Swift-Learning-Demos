//
//  APIStructure.swift
//  APICollectionDemo
//
//  Created by mac on 25/07/24.
//

import Foundation
import Alamofire

struct APIService {
    
    // Fetches posts from the given URL using Codable for JSON parsing
    static func fetchPostsUsingCodable(url: String, method: HTTPMethod, completion: @escaping (Result<[Image], AFError>) -> Void) {
        
        AF.request(url, method: method, encoding: JSONEncoding.default, headers: [:])
            
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            
                            // Decode data into [User] array
                            let images = try JSONDecoder().decode([Image].self, from: data)
                            completion(.success(images))
                            
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
