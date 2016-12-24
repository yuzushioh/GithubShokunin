//
//  WebSocket+Extension.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

import Foundation
import Vapor

extension WebSocket {
    func send(_ node: NodeRepresentable) throws {
        let json = try node.converted(to: JSON.self)
        let message = try json.makeBytes()
        try send(message.string)
    }
}
