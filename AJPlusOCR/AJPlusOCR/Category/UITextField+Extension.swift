//
//  UITextField+Extension.swift
//  Dealers
//
//  Created by 祁志远 on 2017/8/16.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setFieldLeftView(_ imageName: String) {
        let leftBtn = UIButton()
        leftBtn.frame = CGRect(x: 0, y: 0, width: 36, height: 40.5)
        leftBtn.isUserInteractionEnabled = false
        leftBtn.setImage(UIImage(named: imageName), for: .normal)
        self.leftView = leftBtn
        self.leftViewMode = .always
    }


}
