//
//  AppDelegate.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/11.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift
import SHFullscreenPopGestureSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isNetwork : Bool = false
    var isNeedLogin: Bool = true
    
    let manager = NetworkReachabilityManager(host: "https://www.apple.com")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*环境切换 mode: producter 线上生产环境; staging:预发环境；tester：测试环境 developer 开发环境; personal 个人环境*/
        AJDebugManager.shareHelper.switchMode(mode: .developer)
        
        checkLoginStatus()
        
        //初始化一些基础数据
        appInit()
        setupNetwork()
        setMLInputDodgerConfig()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if isNeedLogin {
            setRootLoginController()
        } else {
            setRootHomeController()
        }
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    fileprivate func appInit() {
        SHFullscreenPopGesture.configure()
        AppUpdateManager.checkAppVersion()
//        AppSDKConfigHelper.configUMengAnalyticsInfo() //配置UM统计
    }
    
    
    fileprivate func setMLInputDodgerConfig(){
        //    统一键盘
        IQKeyboardManager .sharedManager().enable = true
        IQKeyboardManager .sharedManager().shouldResignOnTouchOutside = true
    }
    
    func setupNetwork() {
        NetworkReachability.reachability.networkReachability(manager!, reachabilityStatues: { (status) in
            switch status {
            case .notReachability :
                printLog("无网")
                self.isNetwork = false
                
            case .reachability:
                printLog("有网")
                self.isNetwork = true
            }
        })
    }
    
     fileprivate func checkLoginStatus(){
        //是否包含Token
        let userModel = UserModel.loadUserInfo()
        if ((userModel?.token) != nil){
            isNeedLogin = false
        }
    }
    
    //  切换首页
    func setRootHomeController() {
        let homeCtl = HomeViewController()
        let homeNav = AJNavigationViewController(rootViewController: homeCtl)
        self.window?.rootViewController = homeNav
        self.isNeedLogin = false
    }
    //切换登录页面
    func setRootLoginController() {
        let loginCtl = LoginViewController()
        let loginNav = AJNavigationViewController(rootViewController: loginCtl)
        self.window?.rootViewController = loginNav
        self.isNeedLogin = true
    }

}


