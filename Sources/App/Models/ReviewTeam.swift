//
//  ReviewTeam.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//

import Vapor

struct ReviewTeam {
    let members: [GithubUser]
}

extension ReviewTeam: NodeInitializable {
    init(node: Node, in context: Context) throws {
        members = try node.nodeArray?.flatMap { try GithubUser(node: $0) } ?? []
    }
}
