//
//  LikeListCell.swift
//  UBFit
//
//  Created by mac on 09/08/24.
//

import UIKit
import SDWebImage

class LikeListCell: UITableViewCell {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var profileImgView: UIView!
    @IBOutlet var likeBtnView: UIView!
    
    @IBOutlet var btnFollow: UIButton!
    
    @IBOutlet var profileImg: UIImageView!
    
    @IBOutlet var lblId: UILabel!
    @IBOutlet var lblName: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeBtnView.layer.cornerRadius = likeBtnView.frame.size.height / 2
        likeBtnView.layer.borderWidth = 1
        likeBtnView.layer.masksToBounds = true
        
        profileImgView.layer.cornerRadius = profileImgView.frame.size.height / 2
        profileImgView.layer.masksToBounds = true
    }

    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func setData(objLikeList: LikeList){
        let urlProfile = URL(string: objLikeList.img ?? "")
        
        let placeholderImage = UIImage(named: "Placeholder-Image")
        
        profileImg.sd_setImage(with: urlProfile, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
        
        lblId.text = objLikeList.fullName ?? ""
        lblName.text = objLikeList.username ?? ""
        
        if objLikeList.userId == UserLocalData.saveUserId {
            likeBtnView.isHidden = true
        }else {
            likeBtnView.isHidden = false
        }
        
        if objLikeList.isFollow == false {
            likeBtnView.layer.borderColor = UIColor.fontColor.cgColor
            btnFollow.backgroundColor = UIColor.buttonColor.withAlphaComponent(0.05)
            btnFollow.setTitle("Follow", for: .normal)
        }else {
            likeBtnView.layer.borderColor = UIColor.gray.cgColor
            btnFollow.backgroundColor = .black
            btnFollow.setTitle("Following", for: .normal)
        }
    }
}
