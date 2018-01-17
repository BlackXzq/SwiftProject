//
//  LoginVM.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/16.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class LoginVM: NSObject {
    //修改密码
    class func loginRequest(userName: String,
                            passWord: String,
                            finishedCallback: @escaping (_ resultCode:RequestResult) -> ()) {
        
        let params: [String: Any] = [
            "accountName": userName,
            "password": passWord.md5Ajkey()
        ]
        
        LDBaseReauest.sharedInstance.requestData(urlStrig: LoginPath, params: params, decodeClass: UserModel(), checkUserEmpty: false) { (value, classMode, resultCode) in
            switch resultCode!{
            case  .ok(let message):
                if let homeTestModle = classMode as? UserModel {
                    UserModel.saveUserInfo(userModel: homeTestModle)
                    finishedCallback(.ok(message: message))
                } else {
                    finishedCallback(.failed(message: "数据异常"))
                }
            case .failed(let message):
                finishedCallback(.failed(message: message))
            case .error(let error):
                finishedCallback(.error(error: error))
            }
        }
    }
}
