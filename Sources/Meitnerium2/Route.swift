//
//  Route.swift
//  Meitnerium2
//
//  Created by 井川司 on 2017/12/20.
//

import Foundation
import Prorsum

extension Request {
    public static var allMethods: [Method] {
        get { return [Method.get, Method.post, Method.put, Method.delete, Method.patch, Method.head, Method.trace, Method.options, Method.connect] }
    }
}

public typealias Responder = (Request, Response) -> ()

struct Route {
    let path: String
    let method: [Request.Method]
    let handler: Responder
    
    init(method: Request.Method, path: String, handler: @escaping Responder) {
        self.method = [method]
        self.path = path
        self.handler = handler
    }
    
    init(methods: [Request.Method], path: String, handler: @escaping Responder) {
        self.method = methods
        self.path = path
        self.handler = handler
    }
    
    init(path: String, handler: @escaping Responder) {
        self.method = Request.allMethods
        self.path = path
        self.handler = handler
    }

//    func respond(_ request: Request, _ response: Response, _ responder: @escaping (Chainer) -> Void) {
//        self.handler(request, response, responder)
//    }
}
