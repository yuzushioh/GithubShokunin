//
//  SlackUser.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

import Vapor

struct SlackUser {
    let id: String
    let name: String
}

extension SlackUser: NodeInitializable {
    init(node: Node, in context: Context) throws {
        id = try node.extract("user", "id")
        name = try node.extract("user", "name")
    }
}
