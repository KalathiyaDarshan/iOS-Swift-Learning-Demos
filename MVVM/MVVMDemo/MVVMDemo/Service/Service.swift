//
//  Service.swift
//  MVVMDemo
//
//  Created by Darshan Kalathiya on 09/12/24.
//

import UIKit

class Service: NSObject {

    static let shared = Service()
    
    func getAllMovieData(complation: @escaping([MovieModel]?, Error?) -> ()){
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=bollywood") else {return}
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let err = error{
                complation(nil,err)
                print("Loading Data error : ", err.localizedDescription)
            }else{
                guard let data = data else {return}
                
                do {
                    let result = try JSONDecoder().decode(ResultsModel.self, from: data)
                    print(result)
                    complation(result.results, nil)
                }catch let jsonError{
                    print("json Error: \(jsonError.localizedDescription)")
                }
            }
        }.resume()
    }
}
