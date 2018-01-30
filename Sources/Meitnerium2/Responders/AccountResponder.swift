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
        if let params = try? JSONDecoder().decode(NewAccountRequest.self, from: request.bodyData) {
            let token = makeToken()
            let passwd = BCrypt.hash(password: params.password)

            do {
                var values: [String : Any] = ["email": params.email, "password": passwd, "first_name": params.first_name, "last_name": params.last_name, "token": token, "expiry": Date(timeIntervalSinceNow: 86400)]
                if let zip = params.zip { values["zip"] = zip }
                if let address = params.address { values["address"] = address }
                if let tel = params.tel { values["tel"] = tel }
                if let mobile_tel = params.mobile_tel { values["mobile_tel"] = mobile_tel }
                let results = try knex.insert(into: "account_temporaries", values: values)
                logger.debug("new account: \(results.affectedRows) \(results.insertId)")
                
                let url = URL(string: "http://localhost:9000/v1/mail/newaccount")
                let client = try HTTPClient(url: url!)
                try client.open()
                let headers: Headers = ["User-Agent": "SCL-API-SERVER/4.0"]
                var req = NewAccountMailRequest()
                req.id = UInt(results.insertId)
                let encoder = JSONEncoder()
                _ = try client.request(method: .post, headers: headers, body: encoder.encode(req))
                return (.created, nil)
            }
            catch {
                logger.error("\(#function): failed to insert account_temporaries: \(error)")
            }
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
