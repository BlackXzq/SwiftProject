//
//  CommonObject.swift
//  Driver
//
//  Created by Black on 2017/9/20.
//  Copyright © 2017年 anji-allways. All rights reserved.
//

import UIKit
import RealmSwift

class CommonObject: Object {
    @objc dynamic var key = ""
    @objc dynamic var data = ""
    override static func primaryKey() -> String? {
        return "key"
    }
}
