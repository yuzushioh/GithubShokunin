//
//  PullRequest.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//

import Vapor

struct PullRequest {
    let author: GithubUser
    let title: String
    let url: String
    let number: Int
    let state: String
    let assignee: GithubUser?
    let labels: [String]
}

extension PullRequest: NodeInitializable {
    init(node: Node, in context: Context) throws {
        author = try node.extract("user")
        title = try node.extract("title")
        url = try node.extract("html_url")
        number = try node.extract("number")
        state = try node.extract("state")
        assignee = try node.extract("assign")
        
        let labelsNode = node["labels"]?.nodeArray
        labels = try labelsNode?.flatMap { try $0.extract("name") ?? "" } ?? []
    }
}
