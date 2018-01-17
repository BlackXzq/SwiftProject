//
//  ALMacro.swift
//  ExpressSystem
//
//  Created by Kean on 2017/5/31.
//  Copyright © 2017年 Kean. All rights reserved.
//

import UIKit


/// 第一次启动
let YMFirstLaunch = "firstLaunch"

//是否拖动
let IS_GESTURE_PAN = "isGesturePan"


/// iPhone 5
let isIPhone4S = SCREENH == 480 ? true : false
/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false
/// iPhone 8X
let isIPhone8X = SCREENH == 812 ? true : false

/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height

let kStatusBarH : CGFloat = isIPhone8X ? 44 : 20
let kNavigationBarH : CGFloat = 44
let  kTabbarH : CGFloat = isIPhone8X ? 34 + 49 : 49
let kTitleViewH : CGFloat = 40


//导航背景 橙色
let NAV_BG_COLOR = UIColor("182F55")
 //导航标题颜色
let NAV_TITLE_BAR_COLOR = UIColor("FFFFFF")

//按钮选btn项卡颜色
let BTN_TITLE_COLOR = UIColor("182F55")

//按键btn高亮颜色
let BTN_HIGHT_BACKCOLOR = UIColor("FCC800")

//背景btn不可选择 灰色
let BTN_DIS_BACKCOLOR = UIColor("d7d7d7")

//标题颜色
let TITLE_COLOR = UIColor("182F55")

//辅助橘黄色
let BTN_ORANGE = UIColor("FFA62B")

//正文颜色
let BODY_COLOR = UIColor("999999")

//说明文字
let DESC_COLOR = UIColor("999999")

//分割线
let SUP_SEGMENT_COLOR = UIColor("ececec")


//辅助灰色
let SUP_NORMAL_COLOR = UIColor("DAD8D8")




//背景颜色
let BG_COLOR = UIColor.white

let UIRate = (UIScreen.main.bounds.size.width/375)

let appDelegate = UIApplication.shared.delegate as! AppDelegate



/// prin输出
///
/// - Parameters:
///   - message: 输出内容
///   - logError: 是否错误 default is false
///   - file: 输出文件位置
///   - method: 对应方法
///   - line: 所在行
/*
 #file	String	所在的文件名
 #line	Int	所在的行数
 #column	Int	所在的列数
 #function	String	所在的声明的名字
 */
func printLog<T>(_ message: T,
              _ logError: Bool = false,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    if logError {
        print("\((file as NSString).lastPathComponent)\(method) [Line \(line)]: \(message)")
    } else {
        #if DEBUG
            print("\((file as NSString).lastPathComponent)\(method) [Line \(line)]: \(message)")
        #endif
    }
}


func myMIN(_ x: CGFloat, _ y: CGFloat) -> CGFloat {
    return x < y ? x : y
}
func myMAX(_ x: CGFloat, _ y: CGFloat) -> CGFloat {
    return x > y ? x : y
}

/// 延时执行
func delay(_ seconds: Double = 2, closure: @escaping () -> ()) {
    let _t = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * seconds)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: _t, execute: closure)
}

//group并发执行
func dispatch_group(group: DispatchGroup, closure: @escaping (_ semaphore: DispatchSemaphore) -> ()) {
    DispatchQueue.global().async(group: group, qos: .default, flags: [], execute: {
        let useSemaphore = DispatchSemaphore(value: 0)
        closure(useSemaphore)
        useSemaphore.wait()
    })
}

//以4.7寸屏未基准，根据宽度换算相应尺寸。320， 375， 414
func trueSize(_ value: CGFloat) -> CGFloat {
    return UIRate * value
}

func AJRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

//调取系统电话
func callPhoneNum(_ num: String?) {
    guard let phoneNum = num else {
        printLog("无效手机号")
        return
    }
    let noEmptyPhone = phoneNum.stringByReplacing(of: " ", with: "")
    if noEmptyPhone.isEmpty || Int(noEmptyPhone) == nil  {
        printLog("无效手机号")
        return
    }
    //解决ios10系统的调起系统电话延迟
    DispatchQueue.global().async {
        UIApplication.shared.openURL(URL(string: "telprompt://\(noEmptyPhone)")!)
    }
}




