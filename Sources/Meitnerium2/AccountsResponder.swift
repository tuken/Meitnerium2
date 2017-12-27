//
//  AccountsResponder.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/27.
//

import Foundation
import Prorsum

public struct AccountsHandler {
    
    public static func list(_: Request) -> Response {
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
            do {
                let json = try accounts.jsonEncodedString()
                return Response(status: .ok, body: )
            }
            catch {
//                Log.error(message: "cannot encode json: \(error)")
                return Response(status: .internalServerError)
            }
        }
    }
}
