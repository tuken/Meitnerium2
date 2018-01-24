import Foundation
import Prorsum
import SwiftKnex

var logger = FileLogger()
logger.fileName = "./Meitnerium2.log"

let config = KnexConfig(host: "localhost", user: "root", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var app = HTTPService()

app.addRoute(method: .get, path: "/v4/accounts", AccountsHandler.list)
app.addRoute(method: .get, path: "/v4/account/1", AccountsHandler.detail)

let server = try! HTTPServer(app.responder)
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
