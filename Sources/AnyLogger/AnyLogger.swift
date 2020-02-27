//
//  AnyLogger.swift
//  AlwaysRespectful
//
//  Created by Etienne Vautherin on 27/02/2020.
//  Copyright © 2020 Etienne Vautherin. All rights reserved.
//

import os
import Foundation
import Combine


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


extension Publisher {
//    func handleEvents(receiveSubscription: ((Subscription) -> Void)? = nil, receiveOutput: ((()) -> Void)? = nil, receiveCompletion: ((Subscribers.Completion<Error>) -> Void)? = nil, receiveCancel: (() -> Void)? = nil, receiveRequest: ((Subscribers.Demand) -> Void)? = nil) -> Publishers.HandleEvents<AnyPublisher<(), Error>>
    
    func logDebug(_ identifier: String) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveSubscription: { (subscription) in
                log.debug("\(identifier) receiveSubscription: \(subscription)")
            }, receiveOutput: { (output) in
                log.debug("\(identifier) receiveOutput: \(output)")
            }, receiveCompletion: { (completion) in
                switch (completion) {
                case .finished: log.debug("\(identifier) finished")
                case .failure(let error): log.error("\(identifier) error \(error.localizedDescription)")
                }
            }, receiveCancel: {
                log.debug("\(identifier) receiveCancel")
            }, receiveRequest: { (demand) in
                log.debug("\(identifier) receiveDemand: \(demand)")
            })
            .eraseToAnyPublisher()
    }
}
