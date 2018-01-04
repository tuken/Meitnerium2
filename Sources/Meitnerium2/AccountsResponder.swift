//
//  AccountsResponder.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/27.
//

import Foundation
import Prorsum

public struct AccountsHandler {
    
    public static func list(_: Request) -> (Response.Status, [String : Any]) {
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
//            do {
//                let json = try accounts.jsonEncodedString()
                return (.ok, ["accounts" : accounts])
//            }
//            catch {
//                Log.error(message: "cannot encode json: \(error)")
//                return (.internalServerError, [:])
//            }
        }
        return (.internalServerError, [:])
    }
}
