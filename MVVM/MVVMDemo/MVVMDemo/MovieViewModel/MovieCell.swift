//
//  moviewCell.swift
//  MVVMDemo
//
//  Created by Darshan Kalathiya on 09/12/24.
//

import UIKit

class MovieCell: UITableViewCell {

    func configure(with movie: MovieModel) {
        self.textLabel?.text = movie.artistName
        self.detailTextLabel?.text = movie.trackName
    }
}
