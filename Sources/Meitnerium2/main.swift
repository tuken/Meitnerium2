import Foundation
import Prorsum
import SwiftKnex
import SwiftyJSON

class Model: Entity, Codable {

    required init(row: Row) throws {
    }
}

let config = KnexConfig(host: "localhost", user: "root", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var app = HTTPService()

app.addRoute(method: .get, path: "/v4/accounts", AccountsHandler.list)

let server = try! HTTPServer(app.responder)
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
