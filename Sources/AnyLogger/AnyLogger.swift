//
//  AnyLogger.swift
//  AlwaysRespectful
//
//  Created by Etienne Vautherin on 27/02/2020.
//  Copyright © 2020 Etienne Vautherin. All rights reserved.
//

import os
import Foundation


public var log = AnyLogger()

public protocol Logger {
    func debug(_ message: String)
    func error(_ message: String)
}


public struct AnyLogger: Logger {
    public func debug(_ message: String) {
        os_log("%s", log: OSLog.default, type: .default, message)
    }
    
    public func error(_ message: String) {
        os_log("%s", log: OSLog.default, type: .error, message)
    }
}
