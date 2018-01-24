//
//  AccountsResponder.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/27.
//

import Foundation
import Prorsum

struct AccountsHandler {
    
    static func list(_: Request) -> (Response.Status, Model?) {
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
            return (.ok, try! Account(row: accounts[0]))
        }
        return (.internalServerError, nil)
    }
    
    static func detail(_: Request) -> (Response.Status, Model?) {
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
            return (.ok, try! Account(row: accounts[0]))
        }
        return (.internalServerError, nil)
    }
}
