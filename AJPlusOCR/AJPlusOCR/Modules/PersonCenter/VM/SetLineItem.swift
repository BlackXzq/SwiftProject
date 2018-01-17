//
//  SetLineItem.swift
//  Dealers
//
//  Created by Black on 2017/8/15.
//  Copyright © 2017年 Anji-Allways. All rights reserved.
//

import Foundation

enum LineItemType: Int {
    case normal = 0
    case clearCache
    case helpCenter
    case version
    case ours
}

struct SetLineItem {
    var title: String?
    var detail: String?
    var type: LineItemType?
    
    init(newTitle: String?, newDetail: String?, newType: LineItemType) {
        title = newTitle
        detail = newDetail
        type = newType
    }
}
