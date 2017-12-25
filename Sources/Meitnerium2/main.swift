import Foundation
import Prorsum

var app = HTTPService()

app.addRoute(method: .get, path: "/") { request in
    return Response(status: .ok, body: "Hello World".data)
}

let server = try! HTTPServer(app.responder)
try! server.bind(host: "0.0.0.0", port: 3000)
try! server.listen()

RunLoop.main.run()
