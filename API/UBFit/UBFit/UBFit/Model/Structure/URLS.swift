//
//  URLS.swift
//  UBFit
//
//  Created by mac on 31/07/24.
//

import Foundation

struct URLs {

    static let Staging =  "https://ubfitapp.net/redevelope/mobile_api/api/"
    
    private static let BASE_URL = Staging
    
    // Login/register
    static let login                             = BASE_URL + "Login"
    static let getUserNewsFeedList               = BASE_URL + "GetUserNewsFeedList"
    static let GetCommentsList                   = BASE_URL + "GetCommentsList"
    static let ActionOption                      = BASE_URL + "ActionOption"
    static let GetReplyCommentsList              = BASE_URL + "GetReplyCommentsList"
    static let GetLikesList                      = BASE_URL + "GetLikesList"
    static let PostComments                      = BASE_URL + "PostComments" // New Comment
    static let PostReplyComments                 = BASE_URL + "PostReplyComments"
    
}
