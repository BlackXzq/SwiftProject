//
//  LDBaseReauest.swift
//  Dealers
//
//  Created by KeanQ on 2017/8/26.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON

enum MethodType {
    case get
    case post
}

//请求结果
enum RequestResult{
    case ok(message: String) // code == 000000 请求成功
    case failed(message: String)  //code > 000000 请求失败
    case error(error: Error) //请求出错
}


//定义一个结构体，存储认证相关信息
struct IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:AnyObject
}

private let shareInstance = LDBaseReauest()
private var timeoutInterval: TimeInterval = 60  //请求超时时间

class LDBaseReauest {
    
    class var sharedInstance : LDBaseReauest {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutInterval  // 请求超时时间
        //证书认证
        Alamofire.SessionManager(configuration: config).delegate.sessionDidReceiveChallenge = CertificateTrust.alamofireCertificateTrust
        
        return shareInstance
    }
}


extension LDBaseReauest {
    
    //MARK: -- 请求
    
    /// 请求基类
    ///
    /// - Parameters:
    ///   - type: 请求类型 默认post
    ///   - urlStrig: urlStr
    ///   - params: 请求参数
    ///   - decodeClass: 请求modelClass
    ///   - checkUserEmpty: 是否校验用户可以为空 默认需要校验
    ///   - success: 回调
    func requestData(_ type1 : MethodType = .post, urlStrig: String, params: [String: Any]? = nil, decodeClass: HandyJSON? = nil, checkUserEmpty: Bool = true, success: @escaping (_ response: [String : Any]?, _ classModle: HandyJSON?, _ resultCode:RequestResult?) -> ()) {
        
        let userModel = UserModel.loadUserInfo()
        let token = userModel?.token ?? ""
        let userId = userModel?.userId ?? ""
        let time =  String(Int(Date().timeIntervalSince1970))
        
        if checkUserEmpty {
            if userId.isEmpty || token.isEmpty {
                LoginConfig.logOut()
            }

        }
        
        let sign = self.getSign(reqDataDict: params, timeStr: time, tokenStr: token)
        
        let param: [String: Any] = [
            "token" : token,
            "userId" : userId,
            "sign" : sign,
            "time" : time,
            "reqData" : params ?? ""
        ]
        
        //默认.post
        let method = type1 == .get ? HTTPMethod.get : HTTPMethod.post
        let kServerBaseUrl = AJDebugManager.shareHelper.getAPI(kAJServerBaseUrlKey) ?? kServerBaseUrl_PR
        let urlStr = "\(kServerBaseUrl)\(urlStrig)"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(urlStr, method: method, parameters: param, encoding: JSONEncoding.default, headers:["Content-Type" : "application/json"]).responseJSON { (response) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            switch response.result {
            case .success:
                //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: Any]类型 如果是那么将其传给其定义方法中的success
                if let value = response.result.value as? [String: Any] {
                    let json = JSON(value)
                    printLog(json)
                    let repCode = json["repCode"].intValue
                    let repMsg = json["repMsg"].stringValue
                    guard repCode == 0000 else {
                        printLog("请求出错: \(repMsg)")
                        if repCode == 4002 {
                            LoginConfig.logOut()
                            return
                        } else {
                            success(value, nil, .failed(message: repMsg))
                            return
                        }
                    }
                    let jsonString = String(describing: json["repData"])
                    printLog(jsonString)
                    if decodeClass != nil {
                        //数据转model
                        if let classModle = type(of: decodeClass!).deserialize(from: jsonString) {
                            printLog(classModle)
                            success(value,classModle,.ok(message: repMsg))
                            
                        }else {//转换失败
                            success(value, nil,.ok(message: "成功"))
                        }
                        
                    }else {
                        success(value, nil,.ok(message: "成功"))
                    }
                    
                } else {
                    success(nil, nil, .failed(message: "数据出错"))
                }
                
            case .failure(let error):
                success(nil, nil, .error(error: error))
            }
        }
        
    }
    
    //MARK:- 有关数据处理
    
    private func getSign(reqDataDict: [String: Any]? = nil, timeStr:String, tokenStr: String) -> String {
        
        var reqDataStr:String = ""
        if let paramsDict = reqDataDict {
            reqDataStr = self.creatJsonString(dict: paramsDict)
        }
        
        let valueStr = "reqData=" + reqDataStr + "&time=" + timeStr + "&token=" + tokenStr
        return valueStr.md5()
    }
    
    //formate有序json字符串
    private func creatJsonString(dict: [String: Any]) ->String {
        if (!JSONSerialization.isValidJSONObject(dict)) {
            print("无法解析出JSONString")
            return ""
        }
        var namedPaird = [String]()
        let sortedKeysAndValues = dict.sorted{$0.0 < $1.0}
        for (key, value) in sortedKeysAndValues {
            if value is [String: Any] {
                namedPaird.append("\"\(key)\":\(self.creatJsonString(dict: value as! [String : Any]))")
            } else if value is [Any] {
                namedPaird.append("\"\(key)\":\(value)")
            } else {
                namedPaird.append("\"\(key)\":\"\(value)\"")
            }
        }
        let returnString = namedPaird.joined(separator: ",")
        return "{\(returnString)}"
    }
    
}

