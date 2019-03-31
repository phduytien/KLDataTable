//
//  Customer.swift
//  KLDataTable_Example
//
//  Created by Tien Pham on 3/30/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class Customer: NSObject {
    
    var name = ""
    var email = ""
    var phone = ""
    var address = ""
    
    init(name: String, email: String, phone: String, address: String) {
        super.init()
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
    }
    
}
