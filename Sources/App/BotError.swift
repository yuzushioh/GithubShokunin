//
//  BotError.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

enum BotError: Error {
    case missingSlackConfig
    case missingGithubConfig
    case invalidResponse
}
