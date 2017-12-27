//
//  Accounts.swift
//  Meitnerium
//
//  Created by 井川 司 on 2017/09/20.
//
//

import Foundation
import SwiftKnex

struct Account: Entity, Serializable {
    let id: UInt32
    let account_id: String
    let email: String
    let password: String
    let first_name: String
    let last_name: String
    let zip: String?
    let address: String?
    let tel: String?
    let mobile_tel: String?
    let avatar: String?
    let parent_id: UInt32?
    let gmo_member_id: String?
    let status: UInt8
    let max_users: UInt16
    let max_devices_per_home: UInt16
    let agree: UInt8
    let expired: String?
    let user_agent: UInt8
    let last_signin_at: String?
    let updated_at: String
    let created_at: String
    
    init(row: Row) throws {
        self.id = row["id"] as! UInt32
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
        self.user_agent = row["user_agent"] as! UInt8
        self.last_signin_at = row["last_signin_at"] as? String
        self.updated_at = row["updated_at"] as! String
        self.created_at = row["created_at"] as! String
    }
    
    func serialize() throws -> [String: Any] {
        return [
            "id": self.id,
            "account_id": self.account_id,
            "email": self.email,
            "password": self.password,
            "first_name": self.first_name,
            "last_name": self.last_name,
            "zip": self.zip as Any,
            "address": self.address as Any,
            "tel": self.tel as Any,
            "mobile_tel": self.mobile_tel as Any,
            "avatar": self.avatar as Any,
            "parent_id": self.parent_id as Any,
            "gmo_member_id": self.gmo_member_id as Any,
            "status": self.status,
            "max_users": self.max_users,
            "max_devices_per_home": self.max_devices_per_home,
            "agree": self.agree,
            "expired": self.expired as Any,
            "user_agent": self.user_agent,
            "last_signin_at": self.last_signin_at as Any,
            "updated_at": self.updated_at,
            "created_at": self.created_at,
        ]
    }
}
