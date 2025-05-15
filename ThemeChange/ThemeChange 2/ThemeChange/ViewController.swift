//
//  ViewController.swift
//  ThemeChange
//
//  Created by Darshan Kalathiya on 18/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func navigateFirstScreen(){
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
        navigationController?.pushViewController(firstVC, animated: true)
    }
    
    private func applyTheme(_ style: UIUserInterfaceStyle) {
        guard let window = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene }) as? UIWindowScene else { return }
        
        // Apply theme to the app's window
        window.windows.forEach { window in
            window.overrideUserInterfaceStyle = style
        }
    }
    
    @IBAction func btnDefaultClick(_ sender: UIButton) {
        applyTheme(.unspecified)
        navigateFirstScreen()
    }
    
    @IBAction func btnLightClick(_ sender: UIButton) {
        applyTheme(.light)
        navigateFirstScreen()
       }
    
    @IBAction func btnDarkClick(_ sender: UIButton) {
        applyTheme(.dark)
        navigateFirstScreen()
     }
    
}

