//
//  APIManager.swift
//  UBFit
//
//  Created by mac on 31/07/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    var header: HTTPHeaders = [:]
    
    func loginUser(url: String,dataDictionary: [String : Any], completion: @escaping (Result<LoginResponse, AFError>) -> Void) {
        
        //  print("URL:------", url)
        // print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                //  print("Response:-=========", response)
                //   print(String(data: response.data!, encoding: .utf8) ?? "")
                
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let loginResponse = LoginResponse(json)
                            completion(.success(loginResponse))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func getNewsfeedData(url: String,dataDictionary: [String : Any], completion: @escaping (Result<NewsfeedResponse, AFError>) -> Void) {
        
        print("URL:------", url)
        print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                print("Response:-=========", response)
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let newsfeedResponse = NewsfeedResponse(json)
                            completion(.success(newsfeedResponse))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func getCommentData(url: String,dataDictionary: [String : Any], completion: @escaping (Result<CommentResponse, AFError>) -> Void) {
        
        print("URL:------", url)
        print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                print("Response:-=========", response)
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let commentResponse = CommentResponse(json)
                            completion(.success(commentResponse))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func postNewComment(url: String,dataDictionary: [String : Any], completion: @escaping (Result<NewComment, AFError>) -> Void) {
        
        print("URL:------", url)
        print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                print("Response:-=========", response)
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let commentResponse = NewComment(json)
                            completion(.success(commentResponse))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func getLikeData(url: String,dataDictionary: [String : Any], completion: @escaping (Result<LikeResponse, AFError>) -> Void) {
        
        // print("URL:------", url)
        // print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                // print("Response:-=========", response)
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let likeResponse = LikeResponse(json)
                            completion(.success(likeResponse))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func getCommentReplyData(url: String,dataDictionary: [String : Any], completion: @escaping (Result<CommentReply, AFError>) -> Void) {
        
        // print("URL:------", url)
        // print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                // print("Response:-=========", response)
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let commentReply = CommentReply(json)
                            completion(.success(commentReply))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func postNewCommentReply(url: String,dataDictionary: [String : Any], completion: @escaping (Result<NewCommentReplyResponse, AFError>) -> Void) {
        
        // print("URL:------", url)
        // print("Register Parameters are::------", dataDictionary)
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
                
                // print("Response:-=========", response)
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let newCommentReply = NewCommentReplyResponse(json)
                            completion(.success(newCommentReply))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func getLikeList(url: String,dataDictionary: [String : Any], completion: @escaping (Result<LikeListReply, AFError>) -> Void) {
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
             
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let likeListReply = LikeListReply(json)
                            completion(.success(likeListReply))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
    
    func getFollowResponse(url: String,dataDictionary: [String : Any], completion: @escaping (Result<FollowResponse, AFError>) -> Void) {
        
        AF.request(url, method: .post, parameters: dataDictionary, encoding: JSONEncoding.default, headers: header)
            
            .responseData { response in
             
                switch response.result {
                    
                    case .success(let data):
                        do {
                            
                            let json = try JSON(data: data)
                            let followResponse = FollowResponse(json)
                            completion(.success(followResponse))
                            
                        } catch {
                            completion(.failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }
}
