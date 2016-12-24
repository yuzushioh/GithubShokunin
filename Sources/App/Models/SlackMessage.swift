//
//  SlackMessage.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

import Vapor

struct SlackMessage {
    let id: UInt32
    let channel: String
    let text: String
    let type: String
    
    init(to channel: String, text: String) {
        self.id = UInt32.random()
        self.channel = channel
        self.text = text
        self.type = "message"
    }
}

extension SlackMessage: NodeConvertible {
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "channel": channel,
            "type": "message",
            "text": text]
        )
    }
    
    init(node: Node, in context: Context)  throws {
        id = UInt32.random()
        channel = try node.extract("channel")
        text = try node.extract("text")
        type = try node.extract("type")
    }
}
