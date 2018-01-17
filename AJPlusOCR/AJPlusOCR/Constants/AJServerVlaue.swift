//
//  AJServerVlaue.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/15.
//  Copyright © 2018年 Black. All rights reserved.
//

import Foundation

//当前活跃环境key
let AJNetworkDebugModeKey = "AJNetworkDebugModeKey"

//不同环境key
let AJDebugProducterEnvironmentKey = "AJProducter"
let AJDebugStagingEnvironmentKey = "AJStaging"
let AJDebugTesterEnvironmentKey = "AJTester"
let AJDebugDeveloperEnvironmentKey = "AJDeveloper"
let AJDebugPersonalEnvironmentKey = "AJPersonal"

// 基础环境服务配置key
let kAJServerBaseUrlKey = "AJ基础服务"
let kAJUploadPhotoSeverUrlKey = "AJ图片上传"

/*线上环境*/
let kServerBaseUrl_PR = "http://"
//预发环境
let kServerBaseUrl_ST = "http://"
//测试环境
let kServerBaseUrl_TEST = "http://10.108.10.63:38060/business/"
/*开发环境*/
let kServerBaseUrl_DEV = "http://10.108.10.30:38060/business/"
/*个人环境：李军*/
let kServerBaseUrl_PE = "http://10.108.11.115:38091/business/"



/*开发环境: 上传图片服务器地址地址不变 */
//线上环境
let AJConstUploadPhotoSeverUrl_PR = "http://"
//预发环境
let AJConstUploadPhotoSeverUrl_ST = "http://"
//测试环境
let AJConstUploadPhotoSeverUrl_TEST = "http://10.108.10.58:19999/s3/public/put"
//开发环境
let AJConstUploadPhotoSeverUrl_DEV = "http://10.108.10.58:19999/s3/public/put"
//个人环境
let AJConstUploadPhotoSeverUrl_PE = "http://10.108.10.58:19999/s3/public/put"



//MARK: Parameters Value ======
let CheckEditionInformationKit = "ocr/checkEditionInformation" //版本更新接口

let ResetpasswordKey = "user/resetpassword" //修改密码接口

let LoginPath = "user/login/name"   //登录

let PostCarInfoToStorePath = "storagePlan/addStoragePlanByPhone"  //车辆入库

let QueryDealersListPath = "storagePlan/queryCustomerForOcrDict"




