//
//  APIService.swift
//  BlueSocial
//
//  Created by mac on 29/07/24.
//

import Foundation
import Alamofire

struct APIService {
    
    static func loginUser(url: String, method: HTTPMethod,dataDictionary: [String : Any], completion: @escaping (Result<LoginModel, AFError>) -> Void) {
        print("URL:------", url)
        print("Register Parameters are::------", dataDictionary)
        
        AF.request(url,method: method, parameters: dataDictionary,encoding: JSONEncoding.default,headers: [:])
            .validate()
            
            .responseDecodable(of: LoginModel.self) { response in
                
                switch response.result {
                    case .success(let loginResponse):

                            completion(.success(loginResponse))
                            
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    static func registerUser(url: String, method: HTTPMethod,dataDictionary: [String : Any], completion: @escaping (Result<RegistrationModel, AFError>) -> Void) {
        print("URL:------", url)
        print("Register Parameters are::------", dataDictionary)
        
        AF.request(url,method: method, parameters: dataDictionary,encoding: JSONEncoding.default,headers: [:])
            .validate()
            
            .responseDecodable(of: RegistrationModel.self) { response in
                
                switch response.result {
                    case .success(let registrationResponse):

                            completion(.success(registrationResponse))
                            
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
}
