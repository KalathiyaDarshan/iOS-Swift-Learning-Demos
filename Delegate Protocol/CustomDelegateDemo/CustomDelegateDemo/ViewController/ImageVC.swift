//
//  ImageVC.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 27/03/25.
//

import UIKit
import Photos

class ImageVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var clvImage: UICollectionView!
    @IBOutlet weak var onBtnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!

    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let sharedManager = ContactManager.shared
    var images: [UIImage] = []
    var arrContact: [Contact] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharedManager.delegate = self
        sharedManager.fetchData()
        self.clvImage.register(UINib(nibName: "ImageClvCell", bundle: nil), forCellWithReuseIdentifier: "ImageClvCell")
        checkPhotoLibraryPermission()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnNext(_ sender: UIButton) {
        
        let profilesVC = storyboard?.instantiateViewController(withIdentifier: "ProfilesVC") as! ProfilesVC
        navigationController?.pushViewController(profilesVC, animated: true)
    }
    
    @IBAction func onBtnBackClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
}

// ----------------------------------------------------------
//                       MARK: - UICollectionView DataSource -
// ----------------------------------------------------------
extension ImageVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageClvCell", for: indexPath) as! ImageClvCell
        cell.configCell(img: images[indexPath.row], arrObjContact: arrContact)
        return cell
    }
}

// ----------------------------------------------------------
//                       MARK: - UICollectionView Delegate -
// ----------------------------------------------------------
extension ImageVC : UICollectionViewDelegate {
}

// ---------------------------------------------------------------------------
//                       MARK: - UICollectionView Delegate FlowLayout -
// ---------------------------------------------------------------------------
extension ImageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 10) / 2
        let height = (collectionView.frame.height - 30) / 4
        
        return CGSize(width: width, height: height)
    }
}

// ---------------------------------------------------------------------------
//                       MARK: - FetchImages From Albums -
// ---------------------------------------------------------------------------
extension ImageVC {
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
            case .authorized:
                fetchImages()
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { newStatus in
                    if newStatus == .authorized {
                        self.fetchImages()
                    }
                }
            default:
                print("Permission denied")
        }
    }
    
    func fetchImages() {
        let fetchOptions = PHFetchOptions()
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        fetchResult.enumerateObjects { (asset, _, _) in
            imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: requestOptions) { (image, _) in
                if let image = image {
                    self.images.append(image)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.clvImage.reloadData()
        }
    }
}

// ----------------------------------------------------------
//                       MARK: - ContactManager Delegate -
// ----------------------------------------------------------
extension ImageVC: ContactManagerDelegate {
    func didRetrieveData(_ arrData: [Any]) {
        if let contacts = arrData as? [Contact] {
            arrContact = contacts
            clvImage.reloadData()
        } else {
            print("Error: arrData does not contain Contact objects")
        }
    }
    
    func didRetrieveContactProfileData(_ arrData: [Any]) {
        print("arrProfileCount: ", arrData.count)
    }
}
