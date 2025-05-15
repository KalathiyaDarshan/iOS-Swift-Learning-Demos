//
//  CommnetReplay.swift
//  UBFit
//
//  Created by mac on 08/08/24.
//

import UIKit

class CommentReplayCell: UITableViewCell {
    
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgProfile: UIImageView!
    
    @IBOutlet var profileimgView: UIView!
    @IBOutlet var hideReplyView: UIView!
    @IBOutlet var moreBtnView: UIView!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblLikeCount: UILabel!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var btnReply: UIButton!
    @IBOutlet var btnHide: UIButton!
    @IBOutlet var btnMore: UIButton!
    @IBOutlet var btnReplyLike: UIButton!
    
    @IBOutlet var notesTrallingConstraint: NSLayoutConstraint!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var sectionOrRowDelegate: GetSectionOrRowDelegate?
    var section : Int = 0
    var row: Int = 0
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileimgView.layer.cornerRadius = profileimgView.frame.size.height / 2
        profileimgView.layer.masksToBounds = true
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func cellData(obj: NewCommentReply,objCommentList: CommentList) {
        
        let urlProfile = URL(string: obj.img ?? "")
        let placeholderImage = UIImage(named: "Placeholder-Image")
        
        let attributedText = NSMutableAttributedString(string: "@\(obj.replyUserName ?? "") ", attributes: [
            .font: UIFont.systemFont(ofSize: 13, weight: .medium),
            .foregroundColor: UIColor.fontColor
        ])
        
        // Combine the normal text and attributed text
        let completeText = NSMutableAttributedString(string: obj.userComments ?? "")
        attributedText.append(completeText)
        
        lblName.text = obj.fullName ?? ""
        lblNotes.attributedText = attributedText
        lblLikeCount.text = "\(obj.totalLikes ?? 0)"
        lblTime.text = "\(obj.time ?? "")"
        
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
        
        // Like
        let isLike = obj.isLike ?? false
        
        if isLike == true {
            btnReplyLike.isSelected = true
            btnReplyLike.tintColor = UIColor.red
        }else {
            btnReplyLike.isSelected = false
            btnReplyLike.tintColor = UIColor.textColor
        }
        
        // Reply Hide Show
        if (objCommentList.totalReplyComments ?? 0) <= objCommentList.arrCommentReply.count {
            btnHide.setTitle("---------- Hide replies", for: .normal)
        }else{
            btnHide.setTitle("---------- View \((objCommentList.totalReplyComments ?? 0) - objCommentList.arrCommentReply.count) more reply", for: .normal)
        }
        
        imgProfile.sd_setImage(with: urlProfile, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnMoreClick(_ sender: UIButton) {
        sectionOrRowDelegate?.getSectionOrRow(section: section, row: row)
    }
    
    @IBAction func btnLikeClick(_ sender: UIButton) {
        sectionOrRowDelegate?.likeCommentReply(section: section, row: row)
    }
    
}

protocol GetSectionOrRowDelegate {
    func getSectionOrRow(section: Int,row: Int)
    func likeCommentReply(section: Int,row: Int)
}
