//
//  UserModel.swift
//  Dealers
//
//  Created by 祁志远 on 2017/8/21.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel: NSObject, HandyJSON, NSCoding {
 
    var userId: String? //用户ID
    var token: String? //token
    var name: String? //driverName

    //MARK: NACODING协议
    //2.0 将对象写入到文件中
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(name, forKey: "name")
        
    }
    
    //3.0 从文件中读取对象
    required init?(coder aDecoder: NSCoder) {
        super.init()
        token = aDecoder.decodeObject(forKey: "token") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    required override init(){
        super.init()
    }
    
    
    class func saveUserInfo(userModel: UserModel) {
        NSKeyedArchiver.archiveRootObject(userModel, toFile: UserModel.DomainsPath())
    }
    
    
    class func loadUserInfo() -> UserModel? {
        let userModel =  NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.DomainsPath()) as? UserModel
        return userModel

    }
    
    class func deleteUserInfo() {
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(atPath: UserModel.DomainsPath())
            printLog("user info delete success")
        }catch{
            print("user info delete failure")
        }
        
    }
    
    class func DomainsPath() -> String{
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let filePath = docPath.appendingPathComponent("AJPLUSOCRUserInfo.plist")
        return filePath
    }
    
}





