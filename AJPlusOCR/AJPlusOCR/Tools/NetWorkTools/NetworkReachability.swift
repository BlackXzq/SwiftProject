//
//  NetworkReachability.swift
//  ExpressSystem
//
//  Created by Kean on 2017/5/30.
//  Copyright © 2017年 Kean. All rights reserved.
//

import UIKit
import Alamofire

enum ReachabilityStatues {
    case notReachability
    case reachability
}

class NetworkReachability: NSObject {
    static let reachability = NetworkReachability()
    
    func networkReachability(_ manager : NetworkReachabilityManager, reachabilityStatues: @escaping (ReachabilityStatues) -> Void){
        manager.listener = {status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable || status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown {
                reachabilityStatues(.notReachability)
                print("无网")
            } else if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.ethernetOrWiFi) || status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.wwan){
                reachabilityStatues(.reachability)
                print("有网")
            }
        }
        manager.startListening()
    }
}
