import Foundation
import Prorsum
import SwiftKnex
import SwiftyJSON

let config = KnexConfig(host: "localhost", user: "root", password: "secualpass", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var app = HTTPService()

app.addRoute(method: .get, path: "/v4/accounts", AccountsHandler.list)

let server = try! HTTPServer(app.responder)
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
