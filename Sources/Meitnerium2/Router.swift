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
    static public func ==(l: Request.Method, r: Request.Method) -> Bool {
        return l == r
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
                    route.handler(request, response)
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

