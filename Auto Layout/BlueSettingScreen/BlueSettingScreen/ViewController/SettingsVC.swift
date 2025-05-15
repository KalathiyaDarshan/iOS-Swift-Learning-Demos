//
//  SettingsVC.swift
//  Blue
//
//  Created by Blue.

import UIKit
//import Instabug

class SettingsVC: UIViewController {
    
    // ----------------------------------------------------------
    //                MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var tblSettings: UITableView!
    
    //MARK: - Changed
    @IBOutlet weak var socialCV: UICollectionView!
    
    // ----------------------------------------------------------
    //                MARK: - Property -
    // ----------------------------------------------------------
    private var arrSetting: [Setting] = []
    
    //MARK: - Changed
    var arrSocialObject = [SocialDetail]()
    var collectionViewHeight: CGFloat = 0
    
    // ----------------------------------------------------------
    //                MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Check if content size is greater than the table view's height
        if tblSettings.contentSize.height > tblSettings.frame.size.height {
            tblSettings.isScrollEnabled = true
        } else {
            tblSettings.isScrollEnabled = false
        }
    }

    // Function to open the link in SFSafariViewController
    func navigateToLink(linkValue: String) {
        // Function to open the link in SFSafariViewController
        if let url = URL(string: linkValue) {
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }  else {
               // self.showAlertWithOKButton(message: "Invalid URL")
                print("Invalid URL")
            }
            
        } else {
            //self.showAlertWithOKButton(message: "Invalid URL")
            print("Invalid URL")
        }
    }

    // ----------------------------------------------------------
    //                MARK: - Action -
    // ----------------------------------------------------------
    @IBAction func onBtnBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    private func setupUI() {
        
        self.tblSettings.register(SettingTblCell.nib, forCellReuseIdentifier: SettingTblCell.identifier)
        self.tblSettings.register(TblHeaderCell.nib, forHeaderFooterViewReuseIdentifier: TblHeaderCell.identifier)
        
        //MARK: - Changed
        let nib = UINib(nibName: "SocialCell", bundle: nil)
        socialCV.register(nib, forCellWithReuseIdentifier: "SocialCell")
        creatObject()
        
        let appSetting = Setting(title: "App", settingOption: [
            
            SettingOption(imgSetting: UIImage(named: "ic_terms_of_use"), settingName: "Terms of Use"),
            SettingOption(imgSetting: UIImage(named: "ic_privacy_policy"), settingName: "Privacy Policy"),
            SettingOption(imgSetting: UIImage(named: "ic_leave"), settingName: "Log out"),
            SettingOption(imgSetting: UIImage(named: "ic_delete"), settingName: "Delete account")])
        
        self.arrSetting.append(appSetting)
    }
    
    //MARK: - Changed
    func creatObject(){
        let twitter = SocialDetail(icon: .twitter)
        let instagram = SocialDetail(icon: .instagram)
        let linkedin = SocialDetail(icon: .linkedin)
        let telegram = SocialDetail(icon: .telegram)
        let discord = SocialDetail(icon: .discord)
        let tiktok = SocialDetail(icon: .tiktok)
        let website = SocialDetail(icon: .website)

        arrSocialObject = [twitter, instagram, discord, telegram, tiktok, linkedin, website]
    }
}

// ----------------------------------------------------------
//                MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension SettingsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrSetting.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSetting[section].settingOption.count
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return self.arrSetting[section].title
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.section == 0 {
//            
//            if let cell = self.tblSettings.dequeueReusableCell(withIdentifier: NetworkTblCell.identifier) as? NetworkTblCell {
//                
//                cell.configureCell(indexPath: indexPath, settingDetail: self.arrSetting[indexPath.section])
//                return cell
//            }
//            
//        } else {
//            
//            
//        }
        
        if let cell = self.tblSettings.dequeueReusableCell(withIdentifier: SettingTblCell.identifier) as? SettingTblCell {
            
            cell.imgViewGeneral.image = self.arrSetting[indexPath.section].settingOption[indexPath.row].imgSetting
            cell.lblGeneral.text = self.arrSetting[indexPath.section].settingOption[indexPath.row].settingName
            
            if cell.lblGeneral.text == "Delete account" {
             //   cell.lblGeneral.textColor = UIColor.appRed_E13C3C()
                
            } else {
              //  cell.lblGeneral.textColor = UIColor.appBlack_031227()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// ----------------------------------------------------------
//                MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension SettingsVC: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if let headerView = self.tblSettings.dequeueReusableHeaderFooterView(withIdentifier: TblHeaderCell.identifier) as? TblHeaderCell {
            headerView.lblTitle.text = self.arrSetting[section].title
          //  headerView.lblTitle.textColor = UIColor.appGray_98A2B1()
            return headerView
        }
        return UIView()
    }
}

//MARK: - Changed
// ----------------------------------------------------------
//                MARK: - UICollectionView DataSource -
// ----------------------------------------------------------
extension SettingsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSocialObject.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialCell", for: indexPath) as! SocialCell
        cell.setData(obj: arrSocialObject[indexPath.row])
        return cell
    }
}

// ----------------------------------------------------------
//                MARK: - UICollectionView Delegate -
// ----------------------------------------------------------
extension SettingsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigateToLink(linkValue: arrSocialObject[indexPath.row].icon.rawValue)
      }
    
}

// ----------------------------------------------------------
//                MARK: - UICollectionView Delegate FlowLayout -
// ----------------------------------------------------------
extension SettingsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        collectionViewHeight = collectionView.frame.height
        return CGSize(width: collectionViewHeight, height: collectionViewHeight) // Making cells square
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        let cellWidth: CGFloat = collectionViewHeight
        let minimumLineSpacing: CGFloat = 6
        
        // Calculate the total width of the cells and spacing
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        let totalCellWidth = cellWidth * CGFloat(numberOfItems)
        let totalSpacingWidth = minimumLineSpacing * CGFloat(max(0, numberOfItems - 1))
        let totalContentWidth = totalCellWidth + totalSpacingWidth
        
        // Calculate the remaining horizontal space
        if collectionView.frame.width > totalContentWidth {
            // Center the cells if total content width is smaller than the view width
            let horizontalInset = (collectionView.frame.width - totalContentWidth) / 2
            return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        } else {
            // No insets if content width exceeds view width
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}


struct Setting {
    
    var title: String?
    var settingOption = [SettingOption]()
}

struct SettingOption {
    
    var imgSetting: UIImage?
    var settingName: String?
}
