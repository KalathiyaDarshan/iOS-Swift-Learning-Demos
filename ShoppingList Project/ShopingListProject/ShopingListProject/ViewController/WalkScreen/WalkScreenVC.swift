//
//  WalkScreenVC.swift
//  ShopingListProject
//
//  Created by mac on 18/06/24.
//

import UIKit

class WalkScreenVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var btnSkip: UIButton!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var walkScreenCV: UICollectionView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstCellNib = UINib(nibName: "WalkScreen1Cell", bundle: nil)
        walkScreenCV.register(firstCellNib, forCellWithReuseIdentifier: "WalkScreen1Cell")
        let Cell2Nib = UINib(nibName: "WalkScreen2Cell", bundle: nil)
        walkScreenCV.register(Cell2Nib, forCellWithReuseIdentifier: "WalkScreen2Cell")
        let Cell3Nib = UINib(nibName: "WalkScreen3Cell", bundle: nil)
        walkScreenCV.register(Cell3Nib, forCellWithReuseIdentifier: "WalkScreen3Cell")
        let Cell4Nib = UINib(nibName: "WalkScreen4Cell", bundle: nil)
        walkScreenCV.register(Cell4Nib, forCellWithReuseIdentifier: "WalkScreen4Cell")
        
        pageController.numberOfPages  = 4
        pageController.currentPage = 0

        pageController.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    @objc func pageControlDidChange(_ sender: UIPageControl) {
        let page = sender.currentPage
        let indexPath = IndexPath(item: page, section: 0)
        walkScreenCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func skipAction(_ sender: UIButton) {
        
        UserLocalData.needToSkipIntroScreen = true
        let nexVC = storyboard?.instantiateViewController(identifier: "ShopingListVC") as! ShopingListVC
        navigationController?.pushViewController(nexVC, animated: false)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        let indexPath = IndexPath(item: pageController.currentPage+1, section: 0)
        
        if indexPath.item == 4 {
            
            let nexVC = storyboard?.instantiateViewController(identifier: "ShopingListVC") as! ShopingListVC
            UserLocalData.needToSkipIntroScreen = true
            navigationController?.pushViewController(nexVC, animated: false)
        }
        else{
            walkScreenCV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension WalkScreenVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkScreen\(indexPath.row+1)Cell", for: indexPath) as! WalkScreen1Cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        pageController.currentPage = indexPath.row
        if indexPath.last == 3 {
            btnSkip.isHidden = true
            btnNext.setTitle("OKAY", for: .normal)
        }
        else {
            btnSkip.isHidden = false
            btnNext.setTitle("Next", for: .normal)
        }
    }
}

