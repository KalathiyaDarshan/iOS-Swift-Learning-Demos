//
//  SocialCellModel.swift
//  BlueCollectionView
//
//  Created by Darshan Kalathiya on 18/12/24.
//

import Foundation
import UIKit

class SocialDetail{
    let icon : SocialIcon
        
    init(icon: SocialIcon) {
        self.icon = icon
    }
}

enum SocialIcon: String {
    case twitter = "https://twitter.com/bluesocialapp?lang=en"
    case instagram = "https://www.instagram.com/blue_social/"
    case linkedin = "https://www.linkedin.com/company/bluesocial"
    case telegram = "https://t.me/Blue_Social"
    case discord = "https://discord.gg/U6gFDX7Q4z"
    case tiktok = "https://www.tiktok.com/@bluesocial"
    case website = "https://web3.blue.social"
}
