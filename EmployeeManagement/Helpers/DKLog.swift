//
//  DKLog.swift
//  EmployeeManagement
//
//  Created by Dksh on 27/05/23.
//

import Foundation

@objcMembers class DKLog : NSObject {
    static var mode: Mode = .debug //(AppManager.shared.environmentType == .production) ? .release : .debug

    enum Mode: String {
        case debug
        case release
    }
    
    @objc enum LogType: Int {
        case normal
        case info
        case warning
        case error
        case success

        var name: String {
            switch self {
            case .normal : return ""
            case .info   : return "INFO ℹ️"
            case .warning: return "WARNING ⚠️"
            case .error  : return "ERROR ❌"
            case .success: return "SUCCESS ✅"
            }
        }
    }
    
    static func log(_ items: Any..., separator: String = " ", terminator: String = "\n", fileName: String = #fileID, line: Int = #line, function: String = #function, type: LogType = .normal, mode: Mode = mode) {
        
        let logs = [
            "\(self.className)",
            "\(fileName.components(separatedBy: "/").last ?? fileName)",
            "\(line)",
            "\(function)",
            "\(type.name)",
            "⟹\(items.first ?? "")"
        ].filter({!$0.isEmpty})
        let message = logs.joined(separator: ":")
        
        switch mode {
        case .release:
            print(message, separator: separator, terminator: terminator)
            break
            
        default:
            debugPrint(message, separator: separator, terminator: terminator)
        }
    }
    
}
