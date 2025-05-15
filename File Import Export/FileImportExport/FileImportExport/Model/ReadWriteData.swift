//
//  RawData.swift
//  FileImportExport
//
//  Created by Apple on 03/10/24.
//

import Foundation

struct ReadWriteData: Codable {
    var cellImage: Data?
    var cellName: String
    var cellType: String
    var isFromImport: Bool
    var isFromQR: Bool
    var nfcFormat: String?
    var nfcProtocol: String?
    var nfcValue: String?
    var payload: String?
    var qrCode: String?
    var rawValue: String?
    var recordType: String
    var subtitles: String
    var textSize: Int16
    var title: String?

    init(cellImage: Data? = nil ,cellName: String, cellType: String, isFromImport: Bool = false, isFromQR: Bool = false, nfcFormat: String? = nil, nfcProtocol: String? = nil, nfcValue: String? = nil, payload: String? = nil, qrCode: String? = nil, rawValue: String? = nil, recordType: String, subtitles: String, textSize: Int16 = 0, title: String? = nil) {
        self.cellImage = cellImage
        self.cellName = cellName
        self.cellType = cellType
        self.isFromImport = isFromImport
        self.isFromQR = isFromQR
        self.nfcFormat = nfcFormat
        self.nfcProtocol = nfcProtocol
        self.nfcValue = nfcValue
        self.payload = payload
        self.qrCode = qrCode
        self.rawValue = rawValue
        self.recordType = recordType
        self.subtitles = subtitles
        self.textSize = textSize
        self.title = title
    }
}
