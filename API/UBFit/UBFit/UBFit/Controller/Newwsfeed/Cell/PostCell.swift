//
//  PostCell.swift
//  UBFit
//
//  Created by mac on 01/08/24.
//

import UIKit
import SDWebImage

class PostCell: UITableViewCell {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var imgPost: UIImageView!
    
    @IBOutlet var profileimgView: UIView!
    @IBOutlet var followbtnView: UIView!
    @IBOutlet var aboutView: UIView!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblAbout: UILabel!
    
    @IBOutlet var btnLikeIcon: UIButton!
    @IBOutlet var btnLikeText: UIButton!
    @IBOutlet var btnComment: UIButton!
    @IBOutlet var btnShare: UIButton!
    @IBOutlet var btnFollow: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followbtnView.layer.cornerRadius = followbtnView.frame.size.height / 2
        followbtnView.layer.borderWidth = 1
        followbtnView.layer.borderColor = UIColor.buttonColor.cgColor
        followbtnView.layer.masksToBounds = true
        
        profileimgView.layer.cornerRadius = profileimgView.frame.size.height / 2
        profileimgView.layer.masksToBounds = true
        
    }
    
    @IBAction func likeBtnAction(_ sender: UIButton) {
        
    }
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func cellData(obj: NewsFeedPost?) {
        
        let urlProfile = URL(string: obj?.img ?? "")
        
        let placeholderImage = UIImage(named: "Placeholder-Image")
        
        imgProfile.sd_setImage(with: urlProfile, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
        
        lblName.text = obj?.fullName ?? ""
        lblTime.text = obj?.time ?? ""
        btnLikeText.setTitle(" \(obj?.likes ?? "") Likes" , for: .normal)
        btnComment.setTitle(" \(obj?.comments ?? "") Comments" , for: .normal)
        
        let isLike = obj?.isLike ?? false
        
        if isLike == true {
            btnLikeIcon.isSelected = true
            btnLikeIcon.tintColor = UIColor.red
        }else {
            btnLikeIcon.isSelected = false
            btnLikeIcon.tintColor = UIColor.textColor
        }
        
        if obj?.description == ""{
            aboutView.isHidden = true
        }else {
            aboutView.isHidden = false
            lblAbout.text = obj?.description ?? ""
        }
        
        if obj?.isFollow == false {
            btnFollow.backgroundColor = .buttonColor
            btnFollow.setTitle("Follow", for: .normal)
        }else {
            btnFollow.backgroundColor = .clear
            btnFollow.setTitle("Following", for: .normal)
        }
        
        if let imageURLString = obj?.images?.first, let urlPost = URL(string: imageURLString) {
            imgPost.sd_setImage(with: urlPost, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
        } else {
            // Handle the case where there is no valid URL string
            imgPost.image = placeholderImage
        }
    }
}
