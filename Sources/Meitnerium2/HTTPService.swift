//
//  Router.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/21.
//

import Foundation
import Prorsum
import SwiftyJSON

public typealias Responder = (Request) -> (Response.Status, [String : Any])

extension Request.Method: Equatable {
    
    var code: Int {
        switch self {
        case .delete: return 0
        case .get: return 1
        case .head: return 2
        case .post: return 3
        case .put: return 4
        case .connect: return 5
        case .options: return 6
        case .trace: return 7
        case .patch: return 28
        default: return 99
        }
    }
    
    static public func ==(l: Request.Method, r: Request.Method) -> Bool {
        return l.code == r.code
    }
}

protocol RouteAppendable {

    func addedRoute(method: Request.Method, path: String, _ responder: @escaping Responder) -> Self

    func addedRoute(methods: [Request.Method], path: String, _ responder: @escaping Responder) -> Self

    func addedRoute(path: String, _ responder: @escaping Responder) -> Self

    mutating func addRoute(method: Request.Method, path: String, _ responder: @escaping Responder)

    mutating func addRoute(methods: [Request.Method], path: String, _ responder: @escaping Responder)

    mutating func addRoute(path: String, _ responder: @escaping Responder)
}

extension RouteAppendable {

    mutating func addRoute(method: Request.Method, path: String, _ responder: @escaping Responder) {
        self = addedRoute(method: method, path: path, responder)
    }

    mutating func addRoute(methods: [Request.Method], path: String, _ responder: @escaping Responder) {
        self = addedRoute(methods: methods, path: path, responder)
    }

    mutating func addRoute(path: String, _ responder: @escaping Responder) {
        self = addedRoute(path: path, responder)
    }
}

final class HTTPService: RouteAppendable {
    
    private let format = DateFormatter()
    
    var routes: [Route] = []

    lazy var responder: (Request, ResponrWriter) -> Void = { request, writer in
        do {
            var response = Response(status: .notFound)

            for route in self.routes {
                if route.method.contains(request.method) && route.path == request.url.path {
                    let res = route.handler(request)
                    response.status = res.0
                    print(res)
                    let jobj = JSON(res.1 as Any)
                    print(jobj)
                    response.body = .buffer(jobj.description.data)
                    print(response.body)
                    break
                }
            }
            
            response.headers.headers["Date"] = self.format.string(from: Date())
            response.headers.headers["Server"] = "Secual Home Api Server/3.0"
            try writer.serialize(response)
            writer.close()
        }
        catch {
            fatalError("\(error)")
        }
    }

    init() {
        self.format.dateFormat = "E, d MMM yyyy hh:mm:ss z"
        self.format.locale = Locale(identifier: "en_UK")
        self.format.timeZone = TimeZone(identifier: "UTC")
    }
    
    func addedRoute(method: Request.Method, path: String, _ responder: @escaping Responder) -> HTTPService {
        let serv = HTTPService()
        serv.routes.append(Route(method: method, path: path, handler: responder))
        return serv
    }
    
    func addedRoute(methods: [Request.Method], path: String, _ responder: @escaping Responder) -> HTTPService {
        let serv = HTTPService()
        serv.routes.append(Route(methods: methods, path: path, handler: responder))
        return serv
    }
    
    func addedRoute(path: String, _ responder: @escaping Responder) -> HTTPService {
        let serv = HTTPService()
        serv.routes.append(Route(path: path, handler: responder))
        return serv
    }
}

