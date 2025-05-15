//
//  ViewController.swift
//  CollationView
//
//  Created by mac on 03/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var MyCollectionView: UICollectionView!
    
    let colors:[UIColor] = [.black,.blue,.brown,.cyan,.darkGray,.gray,.green,.orange,.red,.yellow,.purple,.link,.systemPink]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.delegate = self
        MyCollectionView.dataSource = self

    }
}

class MyCollactionCell: UICollectionViewCell{
    @IBOutlet var cellView: UIView!
    
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollactionCell
        cell.cellView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = (collectionView.frame.size.width-10)/2
        return CGSize(width: size, height: size)
    }
    
}

