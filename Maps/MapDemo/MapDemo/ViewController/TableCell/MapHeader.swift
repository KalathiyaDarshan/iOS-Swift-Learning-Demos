//
//  MapHeader.swift
//  MapDemo
//
//  Created by Darshan Kalathiya on 27/01/25.
//

import UIKit

class MapHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lblMapName: UILabel!
    
    func configure(with mapItem: MapType) {
        lblMapName.text = mapItem.rawValue
    }
}
