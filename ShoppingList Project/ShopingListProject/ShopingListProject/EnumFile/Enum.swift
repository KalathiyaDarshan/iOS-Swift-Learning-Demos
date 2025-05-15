//
//  Enum.swift
//  ShopingListProject
//
//  Created by mac on 10/07/24.
//

import Foundation

enum Priority: Int,Codable {
    case High = 2
    case Low = 1
    case Normal = 0
}

enum WhichScreen :String{
    case EditScreen
    case AddScreeen
}

enum SortingOrder: String,Codable {
    case ascending
    case descending
}

enum SortingCriteria: String {
    case name
    case priority
}

enum SortBy: String,Codable {
    case name
    case store
    case quantity
    case price
    case category
}
