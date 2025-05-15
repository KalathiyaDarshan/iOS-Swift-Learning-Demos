//
//  MiddleModel.swift
//  FileImportExport
//
//  Created by Apple on 03/10/24.
//

import Foundation

// MARK: - WelcomeElement
class MiddleModel: Codable {
    let tagProfileName, tagProfileDate: String
    let tagProfileLength, tagProfileSize: Int
   // let tagProfileData: [TagProfileDatum]

    enum CodingKeys: String, CodingKey {
        case tagProfileName = "tag.profile.name"
        case tagProfileDate = "tag.profile.date"
        case tagProfileLength = "tag.profile.length"
        case tagProfileSize = "tag.profile.size"
      //  case tagProfileData = "tag.profile.data"
    }

    init(tagProfileName: String, tagProfileDate: String, tagProfileLength: Int, tagProfileSize: Int) {
        self.tagProfileName = tagProfileName
        self.tagProfileDate = tagProfileDate
        self.tagProfileLength = tagProfileLength
        self.tagProfileSize = tagProfileSize
       // self.tagProfileData = tagProfileData
    }
}

/*
// MARK: - TagProfileDatum
class TagProfileDatum: Codable {
    let tagProfileFields: TagProfileFields
    let tagProfileConfig: TagProfileConfig

    enum CodingKeys: String, CodingKey {
        case tagProfileFields = "tag.profile.fields"
        case tagProfileConfig = "tag.profile.config"
    }

    init(tagProfileFields: TagProfileFields, tagProfileConfig: TagProfileConfig) {
        self.tagProfileFields = tagProfileFields
        self.tagProfileConfig = tagProfileConfig
    }
}

// MARK: - TagProfileConfig
class TagProfileConfig: Codable {
    let requestType, itemRecordExtra, itemDescription, itemRecord: String

    init(requestType: String, itemRecordExtra: String, itemDescription: String, itemRecord: String) {
        self.requestType = requestType
        self.itemRecordExtra = itemRecordExtra
        self.itemDescription = itemDescription
        self.itemRecord = itemRecord
    }
}

// MARK: - TagProfileFields
class TagProfileFields: Codable {
    let field1: String

    init(field1: String) {
        self.field1 = field1
    }
}
*/
