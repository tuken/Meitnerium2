//
//  Jsonizable.swift
//  Meitnerium2
//
//  Created by 井川司 on 2018/01/24.
//

import Foundation
import SwiftKnex

protocol Jsonizable {
    
    func jsonize() -> Data
}

typealias Model = Entity & Codable & Jsonizable

extension Jsonizable where Self: Model {
    
    func jsonize() -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let format = DateFormatter()
        format.locale = Locale(identifier: "ja_JP")
        format.timeZone = TimeZone(identifier: "Asia/Tokyo")
        format.dateFormat = "YYYY-MM-dd HH:mm:ss z"
        encoder.dateEncodingStrategy = .formatted(format)
        do {
            return try encoder.encode(self)
        }
        catch {
            logger.error("jsonize error: {\(error)}")
        }
        
        return Data()
    }
}
