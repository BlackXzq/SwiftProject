//
//  ModifyPasswordVM.swift
//  Driver
//
//  Created by Black on 2017/9/25.
//  Copyright © 2017年 anji-allways. All rights reserved.
//

import UIKit

class ModifyPasswordVM: NSObject {
    //修改密码
    class func modifyPasswordRequest(oldPassword: String,
                                     newPassword: String,
                                  finishedCallback: @escaping (_ resultCode:RequestResult) -> ()) {
        
        let params: [String: Any] = [
            "oldPassword": oldPassword.md5Ajkey(),
            "newPassword": newPassword.md5Ajkey()
        ]
        
        LDBaseReauest.sharedInstance.requestData(urlStrig: ResetpasswordKey, params: params) { (value, entity, resultCode) in
            switch resultCode!{
            case  .ok(let message):
                finishedCallback(.ok(message: message))
            case .failed(let message):
                finishedCallback(.failed(message: message))
            case .error(let error):
                finishedCallback(.error(error: error))
            }
        }
    }


}
