//
//  SubmitButton.swift
//  Dealers
//
//  Created by Black on 2017/8/23.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

class SubmitButton: UIButton {
    
    var fillColor: UIColor = BTN_HIGHT_BACKCOLOR {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2)
        fillColor.setFill()
        path.fill()
    }
}
