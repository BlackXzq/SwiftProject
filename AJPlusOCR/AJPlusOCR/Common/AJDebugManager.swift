//
//  AJDebugManager.swift
//  Driver
//
//  Created by Black on 2017/10/9.
//  Copyright © 2017年 anji-allways. All rights reserved.
//

import UIKit

enum AJNetworkDebugMode: Int{
    case producter = 0  //线上生产环境
    case staging       //预发环境
    case tester          // 测试环境
    case developer      // 开发环境
    case personal       //个人环境
}

class AJDebugManager {
    static let shareHelper = AJDebugManager()
    //初始化数据
    init() {
        if AJOfflineDataCache.getData(key: AJDebugProducterEnvironmentKey, decoModel: AJAPIConfigure()) == nil {
            let productMode = self.creatBaseConfigure(mode: .producter)
            AJOfflineDataCache.saveData(data: productMode, key: AJDebugProducterEnvironmentKey)
        }
        
        if AJOfflineDataCache.getData(key: AJDebugStagingEnvironmentKey, decoModel: AJAPIConfigure()) == nil {
            let productMode = self.creatBaseConfigure(mode: .staging)
            AJOfflineDataCache.saveData(data: productMode, key: AJDebugStagingEnvironmentKey)
        }
        
        if AJOfflineDataCache.getData(key: AJDebugTesterEnvironmentKey, decoModel: AJAPIConfigure()) == nil {
            let productMode = self.creatBaseConfigure(mode: .tester)
            AJOfflineDataCache.saveData(data: productMode, key: AJDebugTesterEnvironmentKey)
        }
        
        if AJOfflineDataCache.getData(key: AJDebugDeveloperEnvironmentKey, decoModel: AJAPIConfigure()) == nil {
            let productMode = self.creatBaseConfigure(mode: .developer)
            AJOfflineDataCache.saveData(data: productMode, key: AJDebugDeveloperEnvironmentKey)
        }
        
        if AJOfflineDataCache.getData(key: AJDebugPersonalEnvironmentKey, decoModel: AJAPIConfigure()) == nil {
            let productMode = self.creatBaseConfigure(mode: .personal)
            AJOfflineDataCache.saveData(data: productMode, key: AJDebugPersonalEnvironmentKey)
        }
        
        //添加初始化配置
        self.addAPI(kAJServerBaseUrlKey, kServerBaseUrl_PR,
                    kServerBaseUrl_ST,
                    kServerBaseUrl_TEST,
                    kServerBaseUrl_DEV,
                    kServerBaseUrl_PE)
        self.addAPI(kAJUploadPhotoSeverUrlKey, AJConstUploadPhotoSeverUrl_PR,
                    AJConstUploadPhotoSeverUrl_ST,
                    AJConstUploadPhotoSeverUrl_TEST,
                    AJConstUploadPhotoSeverUrl_DEV,
                    AJConstUploadPhotoSeverUrl_DEV)
    }
    
    //创建基础环境配置
    fileprivate func creatBaseConfigure(mode: AJNetworkDebugMode) -> AJAPIConfigure {
        let currentMode = AJAPIConfigure()
        currentMode.debugMode = mode
        return currentMode
    }
    
    
    // 切换环境
    // 切换环境
    func switchMode(mode: AJNetworkDebugMode, _ fromDebug: Bool = false) {
        if fromDebug {
            switchModeHandler(mode)
        } else {
            #if DEBUG
                switchModeHandler(mode)
            #else
                switchModeHandler(.producter)
            #endif
        }
    }
    
    private func switchModeHandler(_ mode: AJNetworkDebugMode) {
        let tempInt = mode.rawValue
        UserDefaults.standard.set(tempInt, forKey: AJNetworkDebugModeKey)
        UserDefaults.standard.synchronize()
    }
    
    //获取当前环境
    func activeMode() -> AJNetworkDebugMode {
        let useMode = UserDefaults.standard.integer(forKey: AJNetworkDebugModeKey)
        let activeMode: AJNetworkDebugMode = AJNetworkDebugMode(rawValue: useMode) ?? .producter
        return activeMode
    }
    
    //获取当前环境基础配置
    func getActiveConfigure(_ activeMode: AJNetworkDebugMode) -> AJAPIConfigure {
        
        if let configure = AJOfflineDataCache.getData(key: AJDebugManager.toModeKey(mode: activeMode), decoModel: AJAPIConfigure()) as? AJAPIConfigure {
            return configure
        }
        
        return self.creatBaseConfigure(mode: .producter)
    }
    
    class func allModeKey() -> [String] {
        return [AJDebugProducterEnvironmentKey, AJDebugStagingEnvironmentKey, AJDebugTesterEnvironmentKey, AJDebugDeveloperEnvironmentKey, AJDebugPersonalEnvironmentKey]
    }
    
    //根据mode数据key 获取环境mode类型
    class func toAJNetworkDebugMode(modeKey: String) -> AJNetworkDebugMode {
        if modeKey ==  AJDebugDeveloperEnvironmentKey {
            return .developer
        } else if modeKey == AJDebugPersonalEnvironmentKey {
            return .personal
        } else if modeKey == AJDebugTesterEnvironmentKey {
            return .tester
        } else if modeKey == AJDebugStagingEnvironmentKey {
            return .staging
        }
        return .producter
    }
    //根据环境mode获取对应的mode数据key
    class func toModeKey(mode: AJNetworkDebugMode) -> String {
        if mode == .personal {
            return AJDebugPersonalEnvironmentKey
        } else if mode == .developer {
            return AJDebugDeveloperEnvironmentKey
        } else if mode == .tester {
            return AJDebugTesterEnvironmentKey
        } else if mode == .staging {
            return AJDebugStagingEnvironmentKey
        }
        return AJDebugProducterEnvironmentKey
    }
}

extension AJDebugManager {
    //添加配置信息
    func addAPI(_ titleKey: String, _ productDomain: String?,
                _ stagDomain:String?,
                _ testDomain:String?,
                _ devDomain: String?,
                _ personalDomain: String?) {
        
        if titleKey.isEmpty {
            printLog("无效key")
            return
        }
        
        if productDomain != nil {
            if let configure = AJOfflineDataCache.getData(key: AJDebugProducterEnvironmentKey, decoModel: AJAPIConfigure()) as? AJAPIConfigure {
                configure.valueDict[titleKey] = productDomain
                AJOfflineDataCache.saveData(data: configure, key: AJDebugProducterEnvironmentKey)
            }
        }
        
        if stagDomain != nil {
            if let configure = AJOfflineDataCache.getData(key: AJDebugStagingEnvironmentKey, decoModel: AJAPIConfigure()) as? AJAPIConfigure {
                configure.valueDict[titleKey] = stagDomain
                AJOfflineDataCache.saveData(data: configure, key: AJDebugStagingEnvironmentKey)
            }
        }
        
        if testDomain != nil {
            if let configure = AJOfflineDataCache.getData(key: AJDebugTesterEnvironmentKey, decoModel: AJAPIConfigure()) as? AJAPIConfigure {
                configure.valueDict[titleKey] = testDomain
                AJOfflineDataCache.saveData(data: configure, key: AJDebugTesterEnvironmentKey)
            }
        }
        
        if devDomain != nil {
            if let configure = AJOfflineDataCache.getData(key: AJDebugDeveloperEnvironmentKey, decoModel: AJAPIConfigure()) as? AJAPIConfigure {
                configure.valueDict[titleKey] = devDomain
                AJOfflineDataCache.saveData(data: configure, key: AJDebugDeveloperEnvironmentKey)
            }
        }
        
        if personalDomain != nil {
            if let configure = AJOfflineDataCache.getData(key: AJDebugPersonalEnvironmentKey, decoModel: AJAPIConfigure()) as? AJAPIConfigure {
                configure.valueDict[titleKey] = personalDomain
                AJOfflineDataCache.saveData(data: configure, key: AJDebugPersonalEnvironmentKey)
            }
        }
        
    }
    //根据key获取基础服务URL
    func getAPI(_ titleKey: String) -> String? {
        if titleKey.isEmpty {
            return nil
        }
        let activeMode = AJDebugManager.shareHelper.activeMode()
        let activeConfigure = self.getActiveConfigure(activeMode)
        return activeConfigure.valueDict[titleKey]
    }
}

// MARK:- 基础配置model
class AJAPIConfigure: BaseModel {
    var debugMode: AJNetworkDebugMode = .producter
    var valueDict = [String: String]()
}
