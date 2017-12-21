import Foundation
import Prorsum

var app = Meitnerium()

app.addRoute(method: .get, path: "/") { request, response in
    response.status = .ok
    response.body = .buffer("Hello World".data)
}

let server = try! HTTPServer(app.responder)
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
