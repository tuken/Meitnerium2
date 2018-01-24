//
//  FileLogger.swift
//  Meitnerium2
//
//  Created by 井川司 on 2018/01/24.
//

import Foundation

struct FileLogger {
    
    var fileName = "./log.txt"
    
    var isConsole = true
    
    private let format = DateFormatter()

    init() {
        self.format.locale = Locale(identifier: "ja_JP")
        self.format.timeZone = TimeZone(identifier: "Asia/Tokyo")
        self.format.dateFormat = "YYYY/MM/dd HH:mm:ss"
    }
    
    private func write(url: URL, text: String) -> Bool {
        guard let stream = OutputStream(url: url, append: true) else { return false }
        
        stream.open()
        defer { stream.close() }
        
        guard let data = text.data(using: .utf8) else { return false }
        let result = data.withUnsafeBytes { stream.write($0, maxLength: data.count) }
        return (result > 0)
    }
    
    func log(priority: String, _ args: String) {
        let now = Date()
        let log = "\(priority) [\(self.format.string(from: now))] \(args)\n"
        if !write(url: URL(fileURLWithPath: self.fileName), text: log) {
            print("cannot write to file: {\(log)}")
        }
        
        if self.isConsole { print(log) }
    }
    
    func debug(_ message: String) {
        log(priority: "[DEBUG]", message)
    }
    
    func info(_ message: String) {
        log(priority: "[INFO]", message)
    }
    
    func warning(_ message: String) {
        log(priority: "[WARNING]", message)
    }
    
    func error(_ message: String) {
        log(priority: "[ERROR]", message)
    }
    
    func critical(_ message: String) {
        log(priority: "[CRIT]", message)
    }
    
    func terminal(_ message: String) {
        log(priority: "[EMERG]", message)
    }
}
