//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Darshan Kalathiya on 09/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tblMovie: UITableView!
    
    private let viewModel = MovieViewModel()
    var dataSource: TableViewDataSource<MovieCell, MovieModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        bindViewModel()
        viewModel.fetchMovies()
     }
    
    private func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.setupDataSource()
                self.tblMovie.reloadData()
            }
          }
    }
    
    private func setupDataSource() {
        dataSource = TableViewDataSource(cellIdentifier: "cell", items: viewModel.movies) { cell, movie in
            cell.configure(with: movie)
        }
        tblMovie.dataSource = dataSource
    }
}
