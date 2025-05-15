//
//  MovieViewModel.swift
//  MVVMDemo
//
//  Created by Darshan Kalathiya on 09/12/24.
//

import UIKit

class MovieViewModel {

     var movies = [MovieModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    func fetchMovies() {
        Service.shared.getAllMovieData { [weak self] (movies, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            self.movies = movies ?? []
            
        }
    }
    
   
}
