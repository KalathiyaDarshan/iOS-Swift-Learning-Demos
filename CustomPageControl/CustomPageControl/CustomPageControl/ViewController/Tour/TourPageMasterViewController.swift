//
//  TourPageMasterViewController.swift
//  Blue
//
//  Created by Blue.

import UIKit

class TourPageMasterViewController: BaseVC {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tourPageMasterButtonCollection            : [UIButton]!
    @IBOutlet weak var nextButton                           : UIButton!
    @IBOutlet weak var nfcActivationButton                  : CustomButton!
    @IBOutlet weak var nfcActivationButtonHeightConstraint  : NSLayoutConstraint!
    @IBOutlet weak var nfcActivationBottomConstraint        : NSLayoutConstraint!
    @IBOutlet weak var pageMasterView                       : UIView!
    {
        willSet {
            self.addChild(self.pageMaster)
         newValue.addSubview(self.pageMaster.view)
            newValue.fitToSelf(childView: self.pageMaster.view)
            self.pageMaster.didMove(toParent: self)
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    private let pageMaster                     = PageMaster([])
    var viewControllerList: [UIViewController] = [ TourScreen1ViewController.instantiate(fromAppStoryboard: .Main),
                                                   TourScreen2ViewController.instantiate(fromAppStoryboard: .Main),
                                                   TourScreen3ViewController.instantiate(fromAppStoryboard: .Main),
                                                   TourScreen4ViewController.instantiate(fromAppStoryboard: .Main),
                                                   TourScreen5ViewController.instantiate(fromAppStoryboard: .Main) ]
    internal var isFromSettings                : Bool = false
    internal var isFromRegister                : Bool = false
    var lastOpenedTourScreen = 0
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.nfcActivationButton.isHorizontal = true
        self.prepareTourPageMaster()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    deinit {
        print("deinit successful. No Retain Cycle/Leak! in \(self)")
    }
    
    // ----------------------------------------------------------
    //                       MARK: - View Methods -
    // ----------------------------------------------------------
    private func prepareTourPageMaster() {
        
        
        if self.isFromSettings {
         //   self.pageMaster.isFromSetting = true
        }
        //MARK: - Changed
        selectedPageButton(button: self.tourPageMasterButtonCollection[0])
        self.setupPageViewController()
    }
    
    //MARK: - Changed
    private func selectedPageButton(button: UIButton) {
        button.isSelected = true
        button.alpha = 1.0
        button.backgroundColor = .appBlue_0066FF()
        
        self.tourPageMasterButtonCollection.enumerated().forEach { index, selectButton in
            if selectButton == button {
                setButtonWidth(selectButton, width: 32) // Set width to 32 for the selected button
            } else {
                setButtonWidth(selectButton, width: 10) // Set width to 10 for all other buttons
            }
        }
        
        // Ensure layout constraints are updated
        self.view.layoutIfNeeded()
    }
    
    private func setButtonWidth(_ button: UIButton, width: Int) {
        // Remove any existing width constraints to avoid duplication
        if let existingWidthConstraint = button.constraints.first(where: { $0.firstAttribute == .width }) {
            button.removeConstraint(existingWidthConstraint)
        }
        
        // Add a new width constraint
        let widthConstraint = button.widthAnchor.constraint(equalToConstant: CGFloat(width))
        widthConstraint.isActive = true
    }
}

// ----------------------------------------------------------
//                       MARK: - Action -
// ----------------------------------------------------------
extension TourPageMasterViewController {
    
    @IBAction func didTapOnNextButton(_ sender: UIButton) {
        
        for (index, button) in self.tourPageMasterButtonCollection.enumerated() {
            
            if button.isSelected {
                
                switch button.tag {
                        
                    case 0:
                        NotificationCenter.default.post(name: .tourOneScreen, object: true, userInfo: nil)
                        break
                    case 1:
                        NotificationCenter.default.post(name: .tourTwoScreen, object: true, userInfo: nil)
                        break
                    case 2:
                        NotificationCenter.default.post(name: .tourThirdScreen, object: true, userInfo: nil)
                        break
                    case 3:
                        //NotificationCenter.default.post(name: .tourFourScreen, object: true, userInfo: nil)
                        break
                    case 4:
                        //NotificationCenter.default.post(name: .tourFiveScreen, object: true, userInfo: nil)
                        break
                    default:
                        break
                }
                
                if button.tag < 4 {
                    self.setSelectedButton(self.tourPageMasterButtonCollection[index + 1])
                    break
                    
                } else {
                    
                    if self.isFromSettings {
                        self.dismiss(animated: true, completion: nil)
                        
                    } else if self.isFromRegister {
                       //  Display Welcome Gift
                      //  let tabbar = MainTabbarController.instantiate(fromAppStoryboard: .Discover)
                     //   tabbar.isFromRegister = true
                      //  self.navigationController?.pushViewController(tabbar, animated: true)
                        
                    } else {
                      //  let tabbar = MainTabbarController.instantiate(fromAppStoryboard: .Discover)
                      // self.navigationController?.pushViewController(tabbar, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func didTapOnActivateNFCButton(_ sender: UIButton) {
        
    }
}

// ----------------------------------------------------------
//                       MARK: - Function -
// ----------------------------------------------------------
extension TourPageMasterViewController {
    
    private func setSelectedButton(_ sender: UIButton) {
        
        self.pageMaster.setPage(sender.tag, animated: true)

        // Reset all buttons' styles
        //MARK: - Changed
        self.tourPageMasterButtonCollection.forEach { button in
            button.alpha = 0.7
            button.isSelected = false
            button.backgroundColor = .appGray_F2F3F4()
            selectedPageButton(button: sender)
        }
        
        if sender.tag == 4 {
            
            // TODO: To Show NFC Activation Button uncomment below code
            // self.nfcActivationButton.isHidden = false
            // self.nfcActivationBottomConstraint.constant = 30.0
            // self.nfcActivationButtonHeightConstraint.constant = 50.0
            // self.nextButton.setTitle("Skip", for: .normal)
            
            self.nfcActivationButton.isHidden = true
            self.nfcActivationBottomConstraint.constant = 0.0
            self.nfcActivationButtonHeightConstraint.constant = 0.0
            self.nextButton.setTitle("Done", for: .normal)
            
        } else {
            
            self.nfcActivationButton.isHidden = true
            self.nfcActivationBottomConstraint.constant = 0.0
            self.nfcActivationButtonHeightConstraint.constant = 0.0
            self.nextButton.setTitle("Continue", for: .normal)
        }
        
        self.pageMaster.setPage(sender.tag, animated: true)
    }
}

// ----------------------------------------------------------
//                       MARK: - API Calling -
// ----------------------------------------------------------
extension TourPageMasterViewController {
    
    // Update user against NFC card | postNFCCardDetail
    private func callUpdateBluePlusUserNFCCardDetailAPI(scanType: String, NFCURL: String) {
        self.view.endEditing(true)
        
        }
    }

// ----------------------------------------------------------
// MARK: - Page Master Delegate
// ----------------------------------------------------------
extension TourPageMasterViewController: PageMasterDelegate {

    func setupPageViewController() {
        self.pageMaster.pageDelegate = self
        self.pageMaster.setup(viewControllerList)
    }

    func pageMaster(_ master: PageMaster, didChangePage page: Int) {
        switch page {
            case 0:
                self.setSelectedButton(self.tourPageMasterButtonCollection[0])

            case 1:
                self.setSelectedButton(self.tourPageMasterButtonCollection[1])

            case 2:
                self.setSelectedButton(self.tourPageMasterButtonCollection[2])

            case 3:
                self.setSelectedButton(self.tourPageMasterButtonCollection[3])

            case 4:
                self.setSelectedButton(self.tourPageMasterButtonCollection[4])

            default:
                break
        }
    }
}

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard = .Main) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

enum AppStoryboard: String {
    
    case  Main
    
    var instance: UIStoryboard {
        
        let name = UIDevice.current.userInterfaceIdiom == .pad ? "\(self.rawValue)_iPad" : self.rawValue
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
