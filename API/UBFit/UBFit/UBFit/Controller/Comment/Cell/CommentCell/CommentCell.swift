//
//  CommentCell.swift
//  UBFit
//
//  Created by mac on 02/08/24.
//

import UIKit
import SDWebImage

class CommentCell: UITableViewCell {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgProfile: UIImageView!
    
    @IBOutlet var profileimgView: UIView!
    @IBOutlet var viewMoreView: UIView!
    @IBOutlet var moreBtnView: UIView!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var btnViewMore: UIButton!
    @IBOutlet var btnReply: UIButton!
    @IBOutlet var btnCommentLike: UIButton!
    @IBOutlet var btnMore: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileimgView.layer.cornerRadius = profileimgView.frame.size.height / 2
        profileimgView.layer.masksToBounds = true
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func cellData(obj: CommentList,viewIsHidden: Bool){
        
        let totalReplyComments = obj.totalReplyComments ?? 0
        let urlProfile = URL(string: obj.img ?? "")
        let placeholderImage = UIImage(named: "Placeholder-Image")
       
        lblName.text = obj.fullName ?? ""
        lblNotes.text = obj.userComments ?? ""
        lblLikeCount.text = "\(obj.totalLikes ?? 0)"
        lblTime.text = obj.time
        
        guard let text = lblNotes.text else { return }
        
        let labelWidth = lblNotes.frame.width
        let textWidth = text.size().width
        
        // More Button Hide Show
        if textWidth > labelWidth {
            moreBtnView.isHidden = false
           
        } else {
            moreBtnView.isHidden = true
        }
        
        // notes Hide Show
        if obj.btnMore == false {
            
            lblNotes.numberOfLines = 0
            btnMore.setTitle("Less", for: .normal)
            
        }else {
            
            lblNotes.numberOfLines = 1
            btnMore.setTitle("More", for: .normal)
        }
        
        if totalReplyComments == 0 {
            
            viewMoreView.isHidden = true
            
        }else {
            
            if obj.arrCommentReply.isEmpty {
                btnViewMore.setTitle("---------- View \(totalReplyComments) more reply", for: .normal)
                viewMoreView.isHidden = false
            }else {
                viewMoreView.isHidden = true
            }
        }
        
        let isLike = obj.isLike ?? false
        
        if isLike == true {
            btnCommentLike.isSelected = true
            btnCommentLike.tintColor = UIColor.red
        }else {
            btnCommentLike.isSelected = false
            btnCommentLike.tintColor = UIColor.textColor
        }
        
        imgProfile.sd_setImage(with: urlProfile, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
    }
}
