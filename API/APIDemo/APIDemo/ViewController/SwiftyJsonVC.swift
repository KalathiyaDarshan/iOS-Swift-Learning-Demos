//
//  SwiftyJsonVC.swift
//  APIDemo
//
//  Created by mac on 25/07/24.
//

import UIKit

class SwiftyJsonVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblAPIData: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var userData: [UserData] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableCellNib = UINib(nibName: "APIResponseCell", bundle: nil)
        tblAPIData.register(tableCellNib, forCellReuseIdentifier: "APIResponseCell")
        
        fetchData()
        
        tblAPIData.tableFooterView = UIView()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func fetchData() {
        
        let url = "https://jsonplaceholder.typicode.com/posts/1/comments"
        
        APIService.fetchPostsUsingSwiftJson(url: url, method: .get) { [weak self] result in
            
            switch result {
                
                case .success(let users):
                    self?.userData = users
                    DispatchQueue.main.async {
                        self?.tblAPIData.reloadData()
                    }
                    
                case .failure(let error):
                    print("Failed to fetch posts:", error)
            }
        }
    }
}

// -------------------------------------------------------------------
//                       MARK: - UITableView DataSource & Delegate -
// -------------------------------------------------------------------
extension SwiftyJsonVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "APIResponseCell", for: indexPath) as! APIResponseCell
        
        cell.setupCellUsingSwiftyJson(obj: userData[indexPath.row])
        
        return cell
    }
}
