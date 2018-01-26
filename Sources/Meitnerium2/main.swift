import Foundation
import Prorsum
import SwiftKnex

//extension Request {
//
//    var bodyParams: [String:Any] {
//        get {
//
//        }
//    }
//}

func makeToken() -> String {
    let ran = Data(URandom().bytes(30))
    return ran.base64EncodedString().replacingOccurrences(of: "=", with: "").replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_")
}

var logger = FileLogger()
logger.fileName = "./Meitnerium2.log"

let config = KnexConfig(host: "localhost", user: "root", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var app = HTTPService()

app.addRoute(method: .post, path: "/v4/account", AccountResponder.new)
app.addRoute(method: .get, path: "/v4/accounts", AccountResponder.list)
app.addRoute(method: .get, path: "/v4/account/1", AccountResponder.detail)

let server = try! HTTPServer(app.responder)
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
