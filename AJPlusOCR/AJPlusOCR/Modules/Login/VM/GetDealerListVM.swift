//
//  GetDealerListVM.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/17.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class GetDealerListVM: NSObject {
    //获取运输订单筛选数据
    class func requesDealersList(name: String?,
                                 finishedCallback: @escaping (_ resultCode:RequestResult, _ entity: DealersListEntity? ) -> ()) {
        
        let params: [String: Any] = [
            "name":name ?? "",
        ]
        
        LDBaseReauest.sharedInstance.requestData(urlStrig: QueryDealersListPath, params: params, decodeClass: DealersListEntity()) { (value, classModel, resultCode) in
            switch resultCode!{
            case  .ok(let message):
                if let entity = classModel as? DealersListEntity {
                    finishedCallback(.ok(message: message), entity)
                } else {
                    finishedCallback(.failed(message: message), nil)
                }
            case .failed(let message):
                printLog(message)
                finishedCallback(.failed(message: message), nil)
                
            case .error(let error):
                printLog(error)
                finishedCallback(.error(error: error), nil)
            }
        }
    }
}

class DealersListEntity: BaseModel {
    var list: [DealerEntity]? //
}

class DealerEntity: BaseModel {
    var code: String?
    var name: String?
}

