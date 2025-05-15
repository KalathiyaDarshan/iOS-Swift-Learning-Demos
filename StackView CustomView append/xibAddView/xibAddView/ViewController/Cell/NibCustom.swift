//
//  NibCustom.swift
//  xibAddView
//
//  Created by Apple on 23/10/24.
//

import UIKit

@IBDesignable class CusomViewWrapper : NibWrapperView<NibCustom> { }

class NibCustom: UIView {

    @IBOutlet weak var lblName: UILabel!
    
}
