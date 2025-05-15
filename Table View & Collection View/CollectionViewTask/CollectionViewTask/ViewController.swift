//
//  ViewController.swift
//  CollectionViewTask
//
//  Created by mac on 06/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var arrCollectionItem = ["1","2","3","4","5","6","7","8","9","10"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collactionViewXibCell = UINib(nibName: "NumbersCell", bundle: nil)
        collectionView.register(collactionViewXibCell, forCellWithReuseIdentifier: "NumbersCell")
    }
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCollectionItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumbersCell", for: indexPath) as! NumbersCell
        cell.lblNumbers.text = "\(arrCollectionItem[indexPath.row])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Vertical
        let size =  (collectionView.frame.size.width)/3
        return CGSize(width: size, height: size)
        
        //Horizontal
        // let size =  (collectionView.frame.size.height)/3
        // return CGSize(width: collectionView.frame.size.width, height: size)
    }
    
}
