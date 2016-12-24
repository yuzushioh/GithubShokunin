//
//  GithubUser.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//

import Vapor

struct GithubUser {
    let id: Int
    let name: String
}

extension GithubUser: NodeInitializable {
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("login")
    }
}
