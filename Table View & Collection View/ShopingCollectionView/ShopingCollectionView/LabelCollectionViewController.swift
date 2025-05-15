//
//  LabelCollectionViewController.swift
//  ShopingCollectionView
//
//  Created by mac on 07/06/24.
//

import UIKit

class LabelCollectionViewController: UIViewController {

    @IBOutlet var cvLabel: UICollectionView!
    var arrLabel = ["dfbfgdbfhg dfgh dfhtf dt drhth drht htt ht fth ","gdf","dfh","dfhfd","sfs","erew","werf","sdg","gdg","dgd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let labelCellNib = UINib(nibName: "LabelCell", bundle: nil)
        cvLabel.register(labelCellNib, forCellWithReuseIdentifier: "LabelCell")
        }
}

extension LabelCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LabelCell", for: indexPath) as! LabelCell
        cell.lblDetail.text = arrLabel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let text = NSAttributedString(string: arrLabel[indexPath.row])
        return CGSize(width: text.size().width,height: text.size().height)

    }
}
