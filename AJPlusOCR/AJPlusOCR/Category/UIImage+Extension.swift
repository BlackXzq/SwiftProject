//
//  UIImage+Extension.swift
//  AJPlusOCR
//
//  Created by xu on 2018/1/15.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

extension UIImage {
    /// 根据颜色生成纯色图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 纯色图片
    class func ld_image(color : UIColor, _ size: CGSize = CGSize(width: 1.0, height: 1.0)) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        // 获得上下文
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return image ?? nil
    }
}
