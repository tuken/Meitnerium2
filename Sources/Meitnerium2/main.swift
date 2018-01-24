import Foundation
import Prorsum
import SwiftKnex
import SwiftyJSON

protocol Jsonizable {

    func jsonize() -> Data
}

typealias Model = Entity & Codable & Jsonizable

extension Jsonizable where Self: Model {
    
    func jsonize() -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let format = DateFormatter()
//        format.locale = Locale(identifier: "ja_JP")
//        format.timeZone = TimeZone(identifier: "Asia/Tokyo")
        format.dateFormat = "YYYY-MM-dd HH:mm:ss z"
        encoder.dateEncodingStrategy = .formatted(format)
        do {
            return try encoder.encode(self)
        }
        catch {
            print("jsonize error: {\(error)}")
        }
        
        return Data()
    }
}

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
