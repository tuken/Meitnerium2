//
//  Router.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/21.
//

import Foundation
import Prorsum

typealias Respond = (Request, ResponrWriter) -> ()

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
    
    mutating func addRoute(method: Request.Method, path: String, _ responder: @escaping Responder)
}

extension RouteAppendable {

    mutating func addRoute(method: Request.Method, path: String, _ responder: @escaping Responder) {
        self = addedRoute(method: method, path: path, responder)
    }
}

final class Meitnerium: RouteAppendable {
    
    var routes: [Route] = []

    lazy var responder: Respond = { request, writer in
        do {
            var response = Response()

            for route in self.routes {
                if route.method.contains(request.method) && route.path == request.url.path {
                    route.handler(request, &response)
                    print(response.body.isBuffer)
                    print(response.body.isEmpty)
                    print(response.body.isReader)
                    print(response.body.isWriter)
                    print(response.body)
                    try writer.serialize(response)
                    writer.close()
                    return
                }
            }
            
            response.status = .notFound
            try writer.serialize(response)
            writer.close()
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    func addedRoute(method: Request.Method, path: String, _ responder: @escaping Responder) -> Meitnerium {
        let meit = Meitnerium()
        meit.routes.append(Route(method: method, path: path, handler: responder))
        return meit
    }
}

