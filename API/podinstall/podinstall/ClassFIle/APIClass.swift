//
//  APIStructure.swift
//  podinstall
//
//  Created by mac on 23/07/24.
//

import Foundation
import Alamofire

class User {
    
    class func callRegisterUserAPI(url: String,method: HTTPMethod,data: [String: Any],completion: @escaping (Result<Data, AFError>) -> Void) {
        
        AF.request(url, method: method, parameters: data, encoding: JSONEncoding.default, headers: [:])
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
}
