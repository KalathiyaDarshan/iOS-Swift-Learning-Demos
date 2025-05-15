//
//  APIModel.swift
//  APICollectionDemo
//
//  Created by mac on 25/07/24.
//

import Foundation

struct Image: Codable {

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String

}
