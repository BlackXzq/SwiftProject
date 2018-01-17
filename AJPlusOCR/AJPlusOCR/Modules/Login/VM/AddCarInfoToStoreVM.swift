//
//  AddCarInfoToStoreVM.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/17.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class AddCarInfoToStoreVM: NSObject {
    //获取运输订单筛选数据
    class func postCarInforToStoreRequest(customerId: String?,
                                          customerName: String?,
                                          vin: String?,
                                          location: String?,
                                          finishedCallback: @escaping (_ resultCode:RequestResult) -> ()) {
        
        let params: [String: Any] = [
            "customerId":customerId ?? "",
            "customerName": customerName ?? "",
            "vin": vin ?? "",
            "location": location ?? ""
        ]
        
        LDBaseReauest.sharedInstance.requestData(urlStrig: PostCarInfoToStorePath, params: params) { (value, entity, resultCode) in
            switch resultCode!{
            case  .ok(let message):
                finishedCallback(.ok(message: message))
            case .failed(let message):
                printLog(message)
                finishedCallback(.failed(message: message))
            case .error(let error):
                printLog(error)
                finishedCallback(.error(error: error))
            }
        }
    }

}
