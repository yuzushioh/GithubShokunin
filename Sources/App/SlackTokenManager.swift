//
//  SlackTokenManager.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/18/16.
//
//

final class SlackTokenManager {
    static let shared = SlackTokenManager()
    
    var token: String? {
        return drop.config["bot-config", "token"]?.string
    }
}
