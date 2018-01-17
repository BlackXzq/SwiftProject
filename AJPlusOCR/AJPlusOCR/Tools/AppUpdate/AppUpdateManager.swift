//
//  AppUpdateManager.swift
//  Dealers
//
//  Created by Black on 2017/9/11.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit

private let kInReviewingKey = "kInReviewingKey"  //用于保存审核状态

typealias checkCompleted = ((_ type: Bool, _ message: String? )->())?

class AppUpdateManager: NSObject {
    
    class func notInReviewing() -> Bool {
        return UserDefaults.standard.bool(forKey: kInReviewingKey)
    }
    // isCheckReview 判断是否是送审状态使用
    class func checkAppVersion(_ isCheckReview: Bool = false, _ completed: checkCompleted = nil) {
        
        let params: [String: Any] = [
            "type":"5",
        ]
        
        LDBaseReauest.sharedInstance.requestData(urlStrig: CheckEditionInformationKit, params: params, decodeClass: AppInfoEntity(), checkUserEmpty: false) { (value, classModel, resultCode) in
            switch resultCode!{
            case  .ok:
                if let entity = classModel as? AppInfoEntity {
                    if let appInfo = entity.appRelease {
                        if compareVersion(onLineVersion: appInfo.versionCode) {
                            if let isupdate = appInfo.isMustUpdate { //强制升级
                                if isupdate == 1 {
                                    updateApp(downloadLink: appInfo.downloadUrl, changelog: appInfo.releaseLog, mustUpdate: true)
                                } else {
                                    updateApp(downloadLink: appInfo.downloadUrl, changelog: appInfo.releaseLog, mustUpdate: false)
                                }
                            } else {
                                updateApp(downloadLink: appInfo.downloadUrl, changelog: appInfo.releaseLog, mustUpdate: false)
                            }
                            
                            if completed != nil {
                                completed!(true, "检测到新版本")
                            }
                            return
                        }
                    }
                }
                if completed != nil {
                    if isCheckReview {
                        completed!(true, "当前已是最新版本")
                    } else {
                        completed!(false, "当前已是最新版本")
                    }
                }
            case .failed, .error:
                if completed != nil {
                    completed!(false, "获取最新版本信息失败")
                }
            }
        }
    }
    
    class private func updateApp(downloadLink: String?, changelog: String?, mustUpdate: Bool) {
        //审核状态的 不提示
        if !notInReviewing() {
            return
        }
        
        let changeMessage = changelog?.replacingOccurrences(of: "==", with: "\n")
        
        let defaultStr = "https://itunes.apple.com/cn/app/id1289585530"
        if mustUpdate {
            DispatchQueue.main.async {
                AJAlterView.showSigleAction(title: "发现新版本", message: changeMessage, confirmTitle: "立即更新", confirmHandler: { (action) in
                    UIApplication.shared.openURL(URL(string: downloadLink ?? defaultStr)!)
                    delay {
                        exit(0)
                    }
                })
            }
        } else {
            DispatchQueue.main.async {
                AJAlterView.showTwoAction(title: "发现新版本，是否更新？", message: changeMessage, confirmTitle: "更新", cacelTitle: "取消", confirmHandler: { (action) in
                    UIApplication.shared.openURL(URL(string: downloadLink ?? defaultStr)!)
                })
            }
        }
    }
        
    //    比较现有版本与线上版本
    class private func compareVersion(onLineVersion: String?) -> Bool {
        if let onlineVer = onLineVersion {
            if onlineVer.isValid() {
                checkReview(onLineVersion: onlineVer)
                let onlineT = self.decomposeVersion(version: onlineVer)
                let localT = self.decomposeVersion(version: getAppVersion())
                
                if onlineT.majorVer > localT.majorVer {
                    return true
                } else if onlineT.subVer > localT.subVer {
                    return true
                } else if onlineT.minVer > localT.minVer {
                    return true
                }
            }
        }
        return false
    }
    // 比较版本号，判断版本是否审核状态
    class private func checkReview(onLineVersion: String) {
        
        let currentReviewing = UserDefaults.standard.bool(forKey: kInReviewingKey)
        if !currentReviewing {
            
            var notInReviewing = false //不在审核中。。。
            let onlineT = self.decomposeVersion(version: onLineVersion)
            let localT = self.decomposeVersion(version: getAppVersion())
            
            let onlineNum = onlineT.majorVer*100 + onlineT.subVer*10 + onlineT.minVer
            let localNum = localT.majorVer*100 + localT.subVer*10 + localT.minVer
            if onlineNum >= localNum {
                notInReviewing = true
            }
            
            UserDefaults.standard.set(notInReviewing, forKey: kInReviewingKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    //获取版本号
    class func getAppVersion() -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let majorVersion = infoDictionary?["CFBundleShortVersionString"] as! String//主程序版本号
        return majorVersion
    }
    
    class func getAppBuildNum() -> String {
        let infoDictionary = Bundle.main.infoDictionary
        let appBuild = infoDictionary?["CFBundleVersion"] as! String//主程序版本号
        return appBuild
    }
    
    class private func decomposeVersion(version: String) -> (majorVer: Int , subVer: Int, minVer: Int) {
        
        let verArray = version.components(separatedBy: ".")
        
        var majorVer: Int = 1
        var subVer: Int = 0
        var minVer: Int = 0
        
        for (index, item) in verArray.enumerated() {
            switch index {
            case 0:
                majorVer = Int(item)!
                break
            case 1:
                subVer = Int(item)!
                break
            case 2:
                minVer = Int(item)!
                break
            default:
                break
            }
        }
        return (majorVer, subVer, minVer)
    }
}


class AppInfoEntity: BaseModel {
    var appRelease:AppReleaseEntity?
}

class AppReleaseEntity: BaseModel {
    var id: String?  //版本ID
    var appName: String?  //app名字
    var versionCode: String?  // 版本号
    var versionName: String?  //版本名称
    var type: String?  // 版本类型 0:未知；1:iOS经销商；2:安卓经销商；3:iOS司机；4:安卓司机
    var downloadUrl: String?  //下载路径
    var isMustUpdate: Int?  //是否强制升级 1:是， 2: 否
    var releaseTime: String?  //发布时间
    var releaseLog: String?  //发布日志
    
}
