//
//  AccountResponder.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/27.
//

import Foundation
import Prorsum
import TurnstileCrypto

struct AccountResponder {
    
    static func new(request: Request) -> (Response.Status, Any?) {
        switch request.body {
        case let .buffer(body):
            if let params = try? JSONDecoder().decode(NewAccountRequest.self, from: body.data) {
                let token = makeToken()
                let passwd = BCrypt.hash(password: params.password)

                do {
                    var values: [String : Any] = ["email": params.email, "password": passwd, "first_name": params.first_name, "last_name": params.last_name, "token": token, "expiry": Date(timeIntervalSinceNow: 86400)]
                    if let zip = params.zip { values["zip"] = zip }
                    if let address = params.address { values["address"] = address }
                    if let tel = params.tel { values["tel"] = tel }
                    if let mobile_tel = params.mobile_tel { values["mobile_tel"] = mobile_tel }
                    let results = try knex.insert(into: "account_temporaries", values: values)
                    print("new account: \(results.affectedRows) \(results.insertId)")
                    return (.created, nil)
                }
                catch {
                    print(error)
                }
            }
        default: break
        }
        return (.internalServerError, nil)
    }

    static func list(_: Request) -> (Response.Status, Any?) {
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
            let accary = try! accounts.map { try Account(row: $0) }
            return (.ok,  accary)
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
