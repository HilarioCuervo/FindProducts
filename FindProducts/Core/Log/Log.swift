//
//  Log.swift
//  FindProducts
//
//  Created by Hilario Cuervo on 13/02/2024.
//

import Foundation

private enum LogLevel: String {
    case info = "[INFO]"
    case error = "[ERROR]"
}

private struct LogContext {
    let file: String
    let function: String
    let line: Int
    
    var description: String {
        return "-> \(file.split(separator: "/").last ?? " "): \(function) - Line: \(line)"
    }
}

struct Log {
    
    static func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logContext = LogContext(file: file, function: function, line: line)
        handleLog(level: .info, context: logContext, message: message)
    }
    
    static func error(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let logContext = LogContext(file: file, function: function, line: line)
        handleLog(level: .error, context: logContext, message: message)
    }
    
    private static func handleLog(level: LogLevel, context: LogContext, message: String) {
        let components = [level.rawValue, message, context.description]

        let fullString = components.joined(separator: " ")
        
        #if DEBUG
        print(fullString)
        #endif
    }
}


