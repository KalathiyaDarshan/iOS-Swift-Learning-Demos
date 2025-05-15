//
//  ViewController.swift
//  APICollectionDemo
//
//  Created by mac on 25/07/24.
//

import UIKit

class ViewController: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgageCV: UICollectionView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrImages: [Image] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let collectionCellNib = UINib(nibName: "ImageCell", bundle: nil)
        imgageCV?.register(collectionCellNib, forCellWithReuseIdentifier: "ImageCell")
        
        fetchData()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func fetchData() {
        
        let url = "https://jsonplaceholder.typicode.com/photos"
        
        APIService.fetchPostsUsingCodable(url: url, method: .get) { result in
            
            switch result {
                
                case .success(let image):
                    self.arrImages = image
                    DispatchQueue.main.async {
                        self.imgageCV.reloadData()
                    }
                    
                case .failure(let error):
                    print("Failed to fetch posts:", error)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.setCellData(obj: arrImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let height = (collectionView.frame.size.height)/7
            let width = (collectionView.frame.size.width-15)/4
            return CGSize(width: width, height: height)
    }
    
}
