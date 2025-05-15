//
//  MovieModel.swift
//  MVVMDemo
//
//  Created by Darshan Kalathiya on 09/12/24.
//

import Foundation
import UIKit

class MovieModel: Decodable {
    var artistName: String?
    var trackName: String?
    
    init(artistName:String, trackName: String){
        self.artistName = artistName
        self.trackName = trackName
    }
}

class ResultsModel: Decodable {
    var results = [MovieModel]()
    
    init(results: [MovieModel]) {
        self.results = results
    }
    
}
