//
//  LikeListVC.swift
//  UBFit
//
//  Created by mac on 05/08/24.
//

import UIKit

class LikeListVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblLikeList: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var pageIndex: Int = 0
    var pageCount: Int = 0
    var arrLikeList: [LikeList] = []
    var objNewsFeedPost: NewsFeedPost?
    var isLoadingMoreData = false
    var userId = UserLocalData.saveUserId
    var loader = Loader.shared
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        let likeListCellNib = UINib(nibName: "LikeListCell", bundle: nil)
        tblLikeList.register(likeListCellNib, forCellReuseIdentifier: "LikeListCell")
        callLikeListAPI()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    // Reset the flag when new data is loaded
    func dataLoadedSuccessfully() {
        isLoadingMoreData = false
    }
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func btnFollowClick(sender: UIButton) {
        
        let status = arrLikeList[sender.tag].isFollow ?? false ? "0" : "1"
        
        let dataDictionary: [String: Any] = [ "status": status,
                                              "id": arrLikeList[sender.tag].userId ?? "",
                                              "user_id": userId,
                                              "action_type": "follow"]
        
        callFollowAPI(dataDictionary: dataDictionary) { response in
            if response {
                print(response)
                
                for (index, post) in self.arrLikeList.enumerated() {
                    if post.userId == self.arrLikeList[sender.tag].userId {
                        self.arrLikeList[index].isFollow?.toggle()
                        
                        // reload only Specific item
                        let indexPath = IndexPath(item: index, section: 0)
                        
                        if let cell = self.tblLikeList.cellForRow(at: indexPath) as? LikeListCell {
                            if status == "0" {
                                cell.likeBtnView.layer.borderColor = UIColor.fontColor.cgColor
                                cell.btnFollow.backgroundColor = UIColor.buttonColor.withAlphaComponent(0.05)
                                cell.btnFollow.setTitle("Follow", for: .normal)
                            }else {
                                cell.likeBtnView.layer.borderColor = UIColor.gray.cgColor
                                cell.btnFollow.backgroundColor = .black
                                cell.btnFollow.setTitle("Following", for: .normal)
                            }
                        }
                    }
                }
            }else {
                print(response)
                self.arrLikeList[sender.tag].isFollow?.toggle()
            }
            
        }
    }
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func callLikeListAPI() {
        self.loader.indicatorStart(view: self.view)
        let dataDictionary: [String: Any] = [ "user_id": userId,
                                              "feed_id": objNewsFeedPost?.feedId ?? "",
                                              "pageIndex": "\(pageIndex)"]
        
        APIManager.shared.getLikeList(url: URLs.GetLikesList, dataDictionary: dataDictionary) { result in
            self.loader.indicatorStop(view: self.view)
            switch result {
                case .success(let likeResponse):
                    if likeResponse.status == true {
                        
                        print("successful")
                        
                        if let likeList = likeResponse.LikeList {
                            for likes in likeList {
                                self.arrLikeList.append(likes)
                            }
                            
                            self.dataLoadedSuccessfully()
                        }
                        
                        self.pageIndex = likeResponse.totalPageIndex ?? 0
                        self.tblLikeList.reloadData()
                        self.pageIndex += 1
                    }else {
                        print("Status False")
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
            }
        }
    }
    
    func callFollowAPI(dataDictionary: [String: Any],completion: @escaping (Bool) -> Void) {
        
        APIManager.shared.getFollowResponse(url: URLs.ActionOption, dataDictionary: dataDictionary) { result in
           
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
extension LikeListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLikeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeListCell") as! LikeListCell
       
        cell.btnFollow.tag = indexPath.row
        cell.setData(objLikeList: arrLikeList[indexPath.row])
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
            
                // Call your API or perform your action here
                if pageIndex < pageCount {
                    self.callLikeListAPI()
                }
            }
        }
    }
}
