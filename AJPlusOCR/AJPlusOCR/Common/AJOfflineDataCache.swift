//
//  AJOfflineDataCache.swift
//  Dealers
//
//  Created by Black on 2017/9/11.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import HandyJSON

class AJOfflineDataCache: NSObject {
    
    //保存数据模型
    class func saveData(data: HandyJSON, key: String, userID: String) {
        let currentKey = key + userID
        saveData(data: data, key: currentKey)
    }
    
    //保存数据模型
    class func saveData(data: HandyJSON, key: String) {
        if key.isValid() {
            let dataString = data.toJSONString()
            if dataString != nil {
                saveData(jsonString: dataString!, key: key)
            }
        }
    }
    
    //保存数据请求的Json字符
    class func saveData(jsonString: String, key: String) {
        let commonOb = CommonObject()
        commonOb.key = key
        commonOb.data = jsonString
        addData(data: commonOb)
    }
    
    class func getData(key: String, decoModel: HandyJSON) -> Any? {
        
        if key.isValid() {
            let realm = try! Realm()
            let useObes = realm.objects(CommonObject.self).filter("key = '\(key)'")
            printLog(useObes.count)
            for value in useObes {
                if value.key == key {
                    let jsonString =  value.data
                    if let classModle = type(of: decoModel).deserialize(from: jsonString) {
                        return classModle
                    }
                }
            }
        }
        return nil
    }
    
    class func removeData(key: String) {
        let realm = try! Realm()
        let useObes = realm.objects(CommonObject.self).filter("key = '\(key)'")
        if useObes.count > 0 {
            try! realm.write {
                realm.delete(useObes)
            }
        }
    }
}

extension AJOfflineDataCache {
    class fileprivate func addData(data: CommonObject) {
        let realm = try! Realm()
        printLog(realm.configuration.fileURL)
        let useObes = realm.objects(CommonObject.self).filter("key = '\(data.key)'")
        if useObes.count > 0 {
            try! realm.write {
                realm.add(data, update: true)
            }
        } else {
            try! realm.write {
                realm.add(data)
            }
        }
    }
}


//fileprivate class commonObject: Object {
//    dynamic var key = ""
//    dynamic var data = ""
//    override static func primaryKey() -> String? {
//        return "key"
//    }
//}



