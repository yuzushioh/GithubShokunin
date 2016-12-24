//
//  SlackManager.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/18/16.
//
//

import Vapor

final class SlackManager {
    static let shared = SlackManager()
    
    func getSlackUserByUserId(_ userId: String) throws -> SlackUser {
        guard let token = SlackTokenManager.shared.token else {
            throw BotError.missingSlackConfig
        }
        
        let response = try drop.client.get(
            SlackAPI.userInformation,
            headers: ["Accept": "application/json; charset=utf-8"],
            query: ["token": token, "user": userId]
        )
        
        guard let json = response.json else {
            throw BotError.invalidResponse
        }
        
        return try SlackUser(node: json.node)
    }
}
