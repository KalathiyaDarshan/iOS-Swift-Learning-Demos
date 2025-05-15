//
//  CommentVC.swift
//  UBFit
//
//  Created by mac on 02/08/24.
//

import UIKit

class CommentVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblComment: UITableView!
    
    @IBOutlet var TagView: UIView!
    
    @IBOutlet var txtViewComment: UITextView!
    
    @IBOutlet var lblTag: UILabel!
    @IBOutlet var lblTxtViewPlaceholder : UILabel!
    
    @IBOutlet var btnPost: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var pageIndex: Int = 0
    var pageCount: Int = 0
    var isLoadingMoreData = false
    var userId = UserLocalData.saveUserId
    var loader = Loader.shared
    
    var isLoading: Bool = false
    var viewIsHidden: Bool = false
    
    var arrcommentList: [CommentList] = []
    var objNewsFeedPost: NewsFeedPost?
    
    var commentCountDelegate: UpdatCommentCountDelegate?
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableCellNib = UINib(nibName: "CommentCell", bundle: nil)
        tblComment.register(tableCellNib, forCellReuseIdentifier: "CommentCell")
        
        let tableReplyCellNib = UINib(nibName: "CommentReplayCell", bundle: nil)
        tblComment.register(tableReplyCellNib, forCellReuseIdentifier: "CommentReplayCell")
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .buttonColor
        
        
        txtViewComment.delegate = self
        tblComment.tableFooterView = activityIndicator
        postBtnSet()
        callCommentAPI()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func postBtnSet(){
        btnPost.layer.borderColor = UIColor.buttonColor.cgColor
        btnPost.layer.borderWidth = 1
        btnPost.layer.cornerRadius = btnPost.frame.size.height/2
        btnPost.layer.masksToBounds = true
    }
    
    // Reset the flag when new data is loaded
    func dataLoadedSuccessfully() {
        isLoadingMoreData = false
    }
    
    func commentReplyCount(section: Int){
        
        if var totalReply = self.arrcommentList[section].totalReplyComments {
            totalReply += 1
            
            self.arrcommentList[section].totalReplyComments = totalReply
            
            let indexPath = IndexPath(row: 0, section: section)
            
            if let cell = self.tblComment.cellForRow(at: indexPath) as? CommentCell {
                cell.btnViewMore.setTitle("---------- View \(totalReply) more reply", for: .normal)
            }
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancelTagAction(_ sender: UIButton) {
        TagView.isHidden = true
    }
    
    @IBAction func postBtnAction(_ sender: UIButton) {
        
        let commentTextView = txtViewComment.text ?? ""
        let commentTrimmedString = commentTextView.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if TagView.isHidden != true {
            
            viewIsHidden = true
            TagView.isHidden = true
            
            callNewCommentReplyAPI(section: sender.tag,desc: commentTrimmedString)
            
        }else{
            
            callNewCommentAPI(desc: commentTrimmedString)
        }
        
        btnPost.isHidden = true
        lblTxtViewPlaceholder.isHidden = false
        
        txtViewComment.resignFirstResponder()
        txtViewComment.text = ""
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Action -
    // ----------------------------------------------------------
    @objc func showReply(sender:UIButton) {
        
        viewIsHidden = true
        callCommentReplyAPI(section: sender.tag)
    }
    
    @objc func commentReply(sender:UIButton) {
        TagView.isHidden = false
        lblTag.text = "@\(arrcommentList[sender.tag].fullName ?? "")"
        btnPost.tag = sender.tag
        txtViewComment.becomeFirstResponder()
    }
    
    @objc func hideReply(sender:UIButton) {
        
        let objComment = arrcommentList[sender.tag]
        
        if let replyCount = objComment.totalReplyComments, replyCount > 0, objComment.arrCommentReply.count >= replyCount
        {
            viewIsHidden = false
            objComment.arrCommentReply.removeAll()
            objComment.currentReplyCount = 0
            objComment.replyPageIndex = 0
           
            sender.setTitle("---------- Hide replies", for: .normal)
            let sectionIndex = IndexSet(integer: sender.tag)
            self.tblComment.reloadSections(sectionIndex, with: .automatic)
            return
        }
        
        if objComment.totalReplyComments ?? 0 > 0, objComment.replyPageIndex == 0
        {
            callCommentReplyAPI(section: sender.tag)
            return
        }
        if objComment.replyPageIndex < objComment.totalPageIndex
        {
            callCommentReplyAPI(section: sender.tag)
        }
    }
    
    @objc func likeIconClick(sender: UIButton) {
       
        let status = arrcommentList[sender.tag].isLike ?? false ? "0" : "1"
        
        arrcommentList[sender.tag].isLike?.toggle()
        
        let likeCount = Int(arrcommentList[sender.tag].totalLikes ?? 0)
        
        if arrcommentList[sender.tag].isLike == true {
            arrcommentList[sender.tag].totalLikes = likeCount + 1
        }else {
            arrcommentList[sender.tag].totalLikes = likeCount - 1
        }
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        
        // Reload the specific row
        if let cell = self.tblComment.cellForRow(at: indexPath) as? CommentCell {
            let isLike = arrcommentList[sender.tag].isLike ?? false
            
            cell.lblLikeCount.text = "\(arrcommentList[sender.tag].totalLikes ?? 0)"
            if isLike == true {
                cell.btnCommentLike.isSelected = true
                cell.btnCommentLike.tintColor = UIColor.red
            }else {
                cell.btnCommentLike.isSelected = false
                cell.btnCommentLike.tintColor = UIColor.textColor
            }
        }
        
        callLikeAPI(id: arrcommentList[sender.tag].commentId ?? "",status: status)
    }
    
    @objc func expandableComment(sender:UIButton) {
        arrcommentList[sender.tag].btnMore.toggle()
        
        let indexPath = IndexPath(row: 0, section: sender.tag)
        tblComment.reloadRows(at: [indexPath], with: .automatic)
    }
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func callCommentAPI() {
        
        if arrcommentList.isEmpty {
            self.loader.indicatorStart(view: self.view)
        }else{
            guard !isLoading else { return }
            isLoading = true
            activityIndicator.startAnimating()
        }
        
        let dataDictionary: [String: Any] = [ "user_id": self.userId,
                                              "feed_id": objNewsFeedPost?.feedId ?? "",
                                              "pageIndex": pageIndex]
        
        APIManager.shared.getCommentData(url: URLs.GetCommentsList, dataDictionary: dataDictionary ) { result in
            
            if self.arrcommentList.isEmpty {
                self.loader.indicatorStop(view: self.view)
            }else {
                self.isLoading = false
                self.activityIndicator.stopAnimating()
            }
            
            switch result {
                case .success(let commentResponse):
                    
                    if commentResponse.status == true {
                        
                        if let commentList = commentResponse.CommentList {
                            for comment in commentList {
                                self.arrcommentList.append(comment)
                            }
                            self.dataLoadedSuccessfully()
                        }
                        
                        self.pageCount = commentResponse.totalPageIndex ?? 0
                        self.tblComment.reloadData()
                        self.pageIndex += 1
                        
                    } else {
                        print("Comment failed: \(commentResponse.message ?? "Unknown error")")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
            }
        }
    }
    
    func callNewCommentAPI(desc: String) {
        self.loader.indicatorStart(view: self.view)
        let dataDictionary: [String: Any] = [ "user_id": userId,
                                              "feed_id": objNewsFeedPost?.feedId ?? "",
                                              "desc": desc,
                                              "reply_id": ""]
        
        APIManager.shared.postNewComment(url: URLs.PostComments, dataDictionary: dataDictionary ) { result in
            self.loader.indicatorStop(view: self.view)
            switch result {
                case .success(let commentResponse):
                    
                    if commentResponse.status == true {
                        
                        if let commentList = commentResponse.commentList {
                            self.arrcommentList.insert(commentList, at: 0)
                        }
                        
                        // NewsFeed Screen Update Comment Count
                        self.commentCountDelegate?.commentCount(commentCount: self.arrcommentList.count,neewsFeedId: self.objNewsFeedPost?.feedId ?? "")
                        self.tblComment.reloadData()
                        
                    } else {
                        print("Comment failed: \(commentResponse.message ?? "Unknown error")")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
            }
        }
    }
    
    func callCommentReplyAPI(section: Int) {
        
        if arrcommentList[section].arrCommentReply.isEmpty {
            self.loader.indicatorStart(view: self.view)
        }else {
            guard !isLoading else { return }
            isLoading = true
            activityIndicator.startAnimating()
        }
        
        let dataDictionary: [String: Any] = ["user_id": userId,
                                             "comment_id": arrcommentList[section].commentId ?? "",
                                             "feed_id": objNewsFeedPost?.feedId ?? "",
                                             "pageIndex":  self.arrcommentList[section].replyPageIndex ]
        
        APIManager.shared.getCommentReplyData(url: URLs.GetReplyCommentsList, dataDictionary: dataDictionary ) { result in
            
            if self.arrcommentList[section].arrCommentReply.isEmpty {
                self.loader.indicatorStop(view: self.view)
            }else {
                self.isLoading = false
                self.activityIndicator.stopAnimating()
            }
            
            switch result {
                case .success(let commentReply):
                    
                    if commentReply.status == true {
                        
                        let commentId = self.arrcommentList[section].commentId
                        
                        if let commentReplyList = commentReply.CommentReplyList {
                            
                            for comment in commentReplyList {
                                
                                if let objCommentList = self.arrcommentList.first(where: { $0.commentId == commentId }) {
                                    
                                    if !objCommentList.arrCommentReply.contains(where: { $0.commentId == comment.commentId }) {
                                            objCommentList.arrCommentReply.append(comment)
                                        objCommentList.currentReplyCount += 1
                                    }
                                    
                                    print("Found comment: \(comment)")
                                }
                                self.arrcommentList[section].totalPageIndex = commentReply.totalPageIndex ?? 0
                            }
                            
                            let sectionIndex = IndexSet(integer: section)
                            
                            self.tblComment.reloadSections(sectionIndex, with: .automatic)
                            self.arrcommentList[section].replyPageIndex += 1
                        } else {
                            
                            print("Comment Reply failed: \(commentReply.message ?? "Unknown error")")
                            
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func callNewCommentReplyAPI(section: Int,desc: String) {
        
        self.loader.indicatorStart(view: self.view)
        
        let dataDictionary: [String: Any] = [ "user_id": userId,
                                              "feed_id": objNewsFeedPost?.feedId ?? "",
                                              "desc": desc,
                                              "reply_id": self.arrcommentList[section].commentId ?? "",
                                              "reply_comment_id": "0" ]
        
        APIManager.shared.postNewCommentReply(url: URLs.PostReplyComments, dataDictionary: dataDictionary ) { result in
            
            self.loader.indicatorStop(view: self.view)
            
            switch result {
                case .success(let commentReply):
                    
                    if commentReply.status == true {
                        
                        if let commentReply = commentReply.commentReplyList {
                            
                            self.arrcommentList[section].arrCommentReply.insert(commentReply, at: 0)
                        
                            print("Found New comment: \(commentReply)")
                            
                            self.commentReplyCount(section: section)
                           
                            let sectionIndex = IndexSet(integer: section)
                            
                            self.tblComment.reloadSections(sectionIndex, with: .automatic)
                            
                        } else {
                            
                            print("Comment Reply failed: \(commentReply.message ?? "Unknown error")")
                            
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func callLikeAPI(id: String ,status: String) {
        
        let dataDictionary: [String: Any] = [ "status": status,
                                              "id": id,
                                              "user_id": userId,
                                              "action_type": "comments_likes"
        ]
        
        APIManager.shared.getLikeData(url: URLs.ActionOption, dataDictionary: dataDictionary) { result in
            
            switch result {
                
                case .success(let likeResponse):
                    if likeResponse.status == true {
                        print("Like")
                    }else {
                        print("Status False")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// ----------------------------------------------------------------
//       MARK: - UITableView DataSource & UITableViewDataSource-
// ----------------------------------------------------------------
extension CommentVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrcommentList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrcommentList[section].arrCommentReply.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            cell.btnViewMore.tag = indexPath.section
            cell.btnCommentLike.tag = indexPath.section
            cell.btnReply.tag = indexPath.section
            cell.btnMore.tag = indexPath.section
            
            cell.cellData(obj: arrcommentList[indexPath.section],viewIsHidden: viewIsHidden)
            
            cell.btnViewMore.addTarget(self, action: #selector(showReply(sender:)), for: .touchUpInside)
            
            cell.btnCommentLike.addTarget(self, action: #selector(likeIconClick(sender:)), for: .touchUpInside)
            
            cell.btnReply.addTarget(self, action: #selector(commentReply(sender:)), for: .touchUpInside)
            
            cell.btnMore.addTarget(self, action: #selector(expandableComment(sender:)), for: .touchUpInside)
            
            return cell
            
        }else {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentReplayCell") as! CommentReplayCell
                
                cell.cellData(obj: arrcommentList[indexPath.section].arrCommentReply[indexPath.row-1],objCommentList: arrcommentList[indexPath.section])
                
                cell.btnHide.tag = indexPath.section
                cell.section = indexPath.section
                cell.row = indexPath.row
                cell.btnReplyLike.tag = indexPath.row-1
                cell.btnReply.tag = indexPath.section
                
                cell.sectionOrRowDelegate = self
                
                if indexPath.row ==  arrcommentList[indexPath.section].arrCommentReply.endIndex {
                    
                    cell.hideReplyView.isHidden = false
                    
                }else {
                    
                    cell.hideReplyView.isHidden = true
                }
                
                cell.btnHide.addTarget(self, action: #selector(hideReply(sender:)), for: .touchUpInside)
                
                cell.btnReply.addTarget(self, action: #selector(commentReply(sender:)), for: .touchUpInside)
                
                return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
        
            if !isLoadingMoreData {
                // Set the flag to true to prevent re-triggering
                isLoadingMoreData = true
            
                // Call your API or perform your action here
                if pageIndex < pageCount {
                    callCommentAPI()
                }
            }
        }
    }
}

extension CommentVC: GetSectionOrRowDelegate {
    func likeCommentReply(section: Int, row: Int) {
        
        let status = arrcommentList[section].arrCommentReply[row-1].isLike ?? false ? "0" : "1"
        
        arrcommentList[section].arrCommentReply[row-1].isLike?.toggle()
        
        let likeCount = Int(arrcommentList[section].arrCommentReply[row-1].totalLikes ?? 0)
        
        if arrcommentList[section].arrCommentReply[row-1].isLike == true {
            arrcommentList[section].arrCommentReply[row-1].totalLikes = likeCount + 1
        }else {
            arrcommentList[section].arrCommentReply[row-1].totalLikes = likeCount - 1
        }
        
        let indexPath = IndexPath(row: row, section: section)
        
        if let cell = self.tblComment.cellForRow(at: indexPath) as? CommentReplayCell {
            
            let isLike = arrcommentList[section].arrCommentReply[row-1].isLike ?? false
            
            cell.lblLikeCount.text = "\(arrcommentList[section].arrCommentReply[row-1].totalLikes ?? 0)"
            
            if isLike == true {
                cell.btnReplyLike.isSelected = true
                cell.btnReplyLike.tintColor = UIColor.red
            }else {
                cell.btnReplyLike.isSelected = false
                cell.btnReplyLike.tintColor = UIColor.textColor
            }
        }
       // tblComment.reloadRows(at: [indexPath], with: .none)
        
        callLikeAPI(id: arrcommentList[section].arrCommentReply[row-1].commentId ?? "",status: status)
    }
    
    // Comment More Less
    func getSectionOrRow(section: Int, row: Int) {
        arrcommentList[section].arrCommentReply[row-1].btnMore.toggle()
        
        let indexPath = IndexPath(row: row, section: section)
        tblComment.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension CommentVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.contentSize.height >= 100 {
            textView.isScrollEnabled = true
            
        } else {
            textView.isScrollEnabled = false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let commentTextView = txtViewComment.text ?? ""
        let commentTrimmedString = commentTextView.trimmingCharacters(in: .whitespacesAndNewlines)
        
        lblTxtViewPlaceholder.isHidden = !textView.text.isEmpty
        btnPost.isHidden = commentTrimmedString.isEmpty
    }
}

protocol UpdatCommentCountDelegate {
    func commentCount(commentCount: Int,neewsFeedId: String)
}
