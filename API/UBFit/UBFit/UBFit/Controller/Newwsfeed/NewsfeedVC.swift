//
//  NewsfeedVC.swift
//  UBFit
//
//  Created by mac on 01/08/24.
//

import UIKit

class NewsfeedVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblPost: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var userId = UserLocalData.saveUserId
    var loader = Loader.shared
    var arrNewsFeedPost: [NewsFeedPost] = []
    var pageIndex: Int = 0
    var pageCount: Int = 0
    var isLoading: Bool = false
    var isLoadingMoreData = false
    let activityIndicator = UIActivityIndicatorView(style: .medium)
   
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableCellNib = UINib(nibName: "PostCell", bundle: nil)
        tblPost.register(tableCellNib, forCellReuseIdentifier: "PostCell")
        
        // Setup activity indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .buttonColor
        
        tblPost.tableFooterView = activityIndicator
        callNewsfeedAPI()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func formattedPost(index: Int) -> String {
        let firstPost = arrNewsFeedPost[index]
        
        var postDetails = ""
        
        if let fullName = firstPost.fullName {
            postDetails += "Full Name: \(fullName)\n"
        }
        
        if let description = firstPost.description {
            postDetails += "Description: \(description)\n"
        }
        
        if let images = firstPost.images {
            postDetails += "Images: \(images.joined(separator: ", "))\n"
        }
        if let video = firstPost.video {
            postDetails += "Video URL: \(video)\n"
        }
        
        return postDetails
    }
    
    // Reset the flag when new data is loaded
    func dataLoadedSuccessfully() {
        isLoadingMoreData = false
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Action -
    // ----------------------------------------------------------
    @objc func shareClick(sender: UIButton) {
        
        let formattedList = formattedPost(index : sender.tag)
        let activityController = UIActivityViewController(activityItems: [formattedList], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
    }
    
    @objc func likeIconClick(sender: UIButton) {
        let status = self.arrNewsFeedPost[sender.tag].isLike ?? false ? "0" : "1"
        
        arrNewsFeedPost[sender.tag].isLike?.toggle()
        
        let likeCount = Int(self.arrNewsFeedPost[sender.tag].likes ?? "") ?? 0
        
        if self.arrNewsFeedPost[sender.tag].isLike == true {
            self.arrNewsFeedPost[sender.tag].likes = "\(likeCount + 1)"
        }else {
            self.arrNewsFeedPost[sender.tag].likes = "\(likeCount - 1)"
        }
        
        let dataDictionary: [String: Any] = [
            "status": status,
            "id": self.arrNewsFeedPost[sender.tag].feedId ?? "",
            "user_id": self.userId,
            "action_type": "likes"
        ]
        
        self.callLikeAPI(dataDictionary: dataDictionary,feedId: self.arrNewsFeedPost[sender.tag].feedId ?? "")
        
        // reload only Specific item
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        if let cell = tblPost.cellForRow(at: indexPath) as? PostCell {
            
            cell.btnLikeText.setTitle(" \(self.arrNewsFeedPost[sender.tag].likes ?? "") Likes" , for: .normal)
            cell.btnComment.setTitle(" \(self.arrNewsFeedPost[sender.tag].comments ?? "") Comments" , for: .normal)
            
            let isLike = self.arrNewsFeedPost[sender.tag].isLike ?? false
            
            if isLike == true {
                cell.btnLikeIcon.isSelected = true
                cell.btnLikeIcon.tintColor = UIColor.red
            }else {
                cell.btnLikeIcon.isSelected = false
                cell.btnLikeIcon.tintColor = UIColor.textColor
            }
        }
        
        // let indexPath = IndexPath(row: sender.tag, section: 0)
        // Reload the specific row
        // self.tblPost.reloadRows(at: [indexPath], with: .none)
        
    }
    
    @objc func likeTextClick(sender: UIButton) {
        
        let likeListVC = storyboard?.instantiateViewController(identifier: "LikeListVC") as! LikeListVC
        likeListVC.objNewsFeedPost = arrNewsFeedPost[sender.tag]
        navigationController?.pushViewController(likeListVC, animated: true)
    }
    
    @objc func commentClick(sender: UIButton) {
        
        let commentVC = storyboard?.instantiateViewController(identifier: "CommentVC") as! CommentVC
        commentVC.objNewsFeedPost = arrNewsFeedPost[sender.tag]
        commentVC.commentCountDelegate = self
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    @objc func btnFollowClick(sender: UIButton) {
        
        // arrNewsFeedPost[sender.tag].isFollow?.toggle()
        
        let status = arrNewsFeedPost[sender.tag].isFollow ?? false ? "0" : "1"
        
        let dataDictionary: [String: Any] = [ "status": status,
                                              "id": arrNewsFeedPost[sender.tag].userId ?? "",
                                              "user_id": userId,
                                              "action_type": "follow"]
        
        callFollowAPI(dataDictionary: dataDictionary) { response in
            if response {
                print(response)
                
                for (index, post) in self.arrNewsFeedPost.enumerated() {
                    if post.userId == self.arrNewsFeedPost[sender.tag].userId {
                        self.arrNewsFeedPost[index].isFollow?.toggle()
                        
                        // reload only Specific item
                        let indexPath = IndexPath(item: index, section: 0)
                        
                        if let cell = self.tblPost.cellForRow(at: indexPath) as? PostCell {
                            if status == "0" {
                                cell.btnFollow.backgroundColor = .buttonColor
                                cell.btnFollow.setTitle("Follow", for: .normal)
                            }else {
                                cell.btnFollow.backgroundColor = .clear
                                cell.btnFollow.setTitle("Following", for: .normal)
                            }
                        }
                    }
                }
            }else {
                print(response)
                self.arrNewsFeedPost[sender.tag].isFollow?.toggle()
            }
            
        }
    }
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    
    
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func callNewsfeedAPI() {
        
        if arrNewsFeedPost.isEmpty {
            self.loader.indicatorStart(view: self.view)
        }else{
            guard !isLoading else { return }
            isLoading = true
            activityIndicator.startAnimating()
        }
        
        let dataDictionary: [String: Any] = [ "user_id": userId,
                                              "pageIndex": "\(pageIndex)"]
        
        APIManager.shared.getNewsfeedData(url: URLs.getUserNewsFeedList, dataDictionary: dataDictionary ) { result in
            
            if self.arrNewsFeedPost.isEmpty {
                self.loader.indicatorStop(view: self.view)
            }else {
                self.isLoading = false
                self.activityIndicator.stopAnimating()
            }
            
            switch result {
                case .success(let newsfeedResponse):
                    
                    if newsfeedResponse.status == true {
                        
                        print("newsfeedResponse successful! Token: \(newsfeedResponse.status ?? false)")
                        
                        if let newPosts = newsfeedResponse.newsFeedPost {
                            for post in newPosts {
                                self.arrNewsFeedPost.append(post)
                            }
                            self.dataLoadedSuccessfully()
                        }
                        
                        self.pageCount = newsfeedResponse.totalPageIndex ?? 0
                        
                        self.tblPost.reloadData()
                        
                    } else {
                        
                        print("newsfeed Response failed: \(newsfeedResponse.message ?? "Unknown error")")
                        
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func callLikeAPI(dataDictionary: [String: Any],feedId: String) {
        
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
    
    func callFollowAPI(dataDictionary: [String: Any],completion: @escaping (Bool) -> Void) {
        self.loader.indicatorStart(view: self.view)
        APIManager.shared.getFollowResponse(url: URLs.ActionOption, dataDictionary: dataDictionary) { result in
          
            self.loader.indicatorStop(view: self.view)
            
            switch result {
                
                case .success(let likeResponse):
                    if likeResponse.status == true {
                        
                        completion(true)
                        
                    }else {
                        print("Status False")
                        completion(false)
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
extension NewsfeedVC : UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNewsFeedPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        cell.cellData(obj: arrNewsFeedPost[indexPath.row])
        
        cell.btnShare.tag = indexPath.row
        cell.btnComment.tag = indexPath.row
        cell.btnLikeText.tag = indexPath.row
        cell.btnLikeIcon.tag = indexPath.row
        cell.btnFollow.tag = indexPath.row
        
        cell.btnShare.addTarget(self, action: #selector(shareClick(sender:)), for: .touchUpInside)
        
        cell.btnLikeIcon.addTarget(self, action: #selector(likeIconClick(sender:)), for: .touchUpInside)
        
        cell.btnLikeText.addTarget(self, action: #selector(likeTextClick(sender:)), for: .touchUpInside)
        
        cell.btnComment.addTarget(self, action: #selector(commentClick(sender:)), for: .touchUpInside)
        
        cell.btnFollow.addTarget(self, action: #selector(btnFollowClick(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
            
            if !isLoadingMoreData {
                // Set the flag to true to prevent re-triggering
                isLoadingMoreData = true
                
                print("contentHeight:", contentHeight)
                print("frameHeight:", frameHeight)
                print("OffSet:", offsetY)
                
                // Call your API or perform your action here
                if pageIndex < pageCount {
                    self.pageIndex += 1
                    callNewsfeedAPI()
                }
            }
        }
    }
}

extension NewsfeedVC: UpdatCommentCountDelegate {
    func commentCount(commentCount: Int, neewsFeedId: String) {
        
        if let index = arrNewsFeedPost.firstIndex(where: { $0.feedId == neewsFeedId }) {
            // Update the fullName property of the object at the found index
            arrNewsFeedPost[index].comments = "\(commentCount)"
            
            let indexPath = IndexPath(item: index, section: 0)
            
            if let cell = self.tblPost.cellForRow(at: indexPath) as? PostCell {
                cell.btnComment.setTitle(" \(arrNewsFeedPost[index].comments ?? "") Comments", for: .normal)
            }
        } else {
            print("Object not found.")
        }
    }
    
}
