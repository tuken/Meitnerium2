//
//  Accounts.swift
//  Meitnerium
//
//  Created by 井川 司 on 2017/09/20.
//
//

import Foundation
import SwiftKnex

class Account: Model {
    let id: UInt
    var account_id: String
    var email: String
    let password: String
    let first_name: String
    let last_name: String
    let zip: String?
    let address: String?
    var tel: String?
    let mobile_tel: String?
    let avatar: String?
    let parent_id: UInt32?
    let gmo_member_id: String?
    let status: UInt8
    let max_users: UInt16
    let max_devices_per_home: UInt16
    let agree: UInt8
    let expired: String?
    let user_agent: UInt8?
    let last_signin_at: Date?
    let updated_at: Date
    let created_at: Date
    
    required init(row: Row) throws {
        self.id = row["id"] as! UInt
        self.account_id = row["account_id"] as! String
        self.email = row["email"] as! String
        self.password = row["password"] as! String
        self.first_name = row["first_name"] as! String
        self.last_name = row["last_name"] as! String
        self.zip = row["zip"] as? String
        self.address = row["address"] as? String
        self.tel = row["tel"] as? String
        self.mobile_tel = row["mobile_tel"] as? String
        self.avatar = row["avatar"] as? String
        self.parent_id = row["parent_id"] as? UInt32
        self.gmo_member_id = row["gmo_member_id"] as? String
        self.status = row["status"] as! UInt8
        self.max_users = row["max_users"] as! UInt16
        self.max_devices_per_home = row["max_devices_per_home"] as! UInt16
        self.agree = row["agree"] as! UInt8
        self.expired = row["expired"] as? String
        self.user_agent = row["user_agent"] as? UInt8
        self.last_signin_at = row["last_signin_at"] as? Date
        self.updated_at = row["updated_at"] as! Date
        self.created_at = row["created_at"] as! Date
        try super.init(row: row)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
