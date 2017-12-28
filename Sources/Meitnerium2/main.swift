import Foundation
import Prorsum
import SwiftKnex
import SwiftyJSON

let config = KnexConfig(host: "localhost", user: "root", password: "secualpass", database: "secual", isShowSQLLog: true)
let con = try! KnexConnection(config: config)
let knex = con.knex()

var app = HTTPService()

app.addRoute(method: .get, path: "/v4/accounts", AccountsHandler.list)

//let server = try! HTTPServer(app.responder)
let server = try! HTTPServer { request, writer in
    do {
        var response = Response(status: .notFound)
        let results = try! knex.table("accounts").fetch()
        if let accounts = results {
                response.status = .ok
                let jobj = JSON(try Account(row: accounts[0]).serialize() as Any)
                print(jobj)
                response.body = .buffer(jobj.description.data)
                print(response.body)
        }
        
//        response.headers.headers["Date"] = self.format.string(from: Date())
        response.headers.headers["Server"] = "Secual Home Api Server/3.0"
        try writer.serialize(response)
        writer.close()
    }
    catch {
        fatalError("\(error)")
    }
}
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
