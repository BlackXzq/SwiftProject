//
//  LoginConfig.swift
//  Dealers
//
//  Created by 祁志远 on 2017/8/15.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

class LoginConfig: NSObject {
    
    public static func login(){
        LoginConfig.logOut()
    }
    
    
    public static func logOut(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isNeedLogin = true
        UserModel.deleteUserInfo()
        appDelegate.setRootLoginController()
    }

}
