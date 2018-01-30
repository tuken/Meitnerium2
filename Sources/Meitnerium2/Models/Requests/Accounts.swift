//
//  Accounts.swift
//  Meitnerium2
//
//  Created by 井川司 on 2018/01/25.
//

import Foundation

struct NewAccountRequest: Decodable {
    
    var email: String = ""
    
    var password: String = ""
    
    var first_name: String = ""
    
    var last_name: String = ""
    
    var zip: String? = nil
    
    var address: String? = nil
    
    var tel: String? = nil
    
    var mobile_tel: String? = nil
}

struct NewAccountMailRequest: Encodable {
    
    var id: UInt = 0
}
