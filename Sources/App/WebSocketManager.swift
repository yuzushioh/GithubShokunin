//
//  WebSocketController.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/23.
//
//

import Vapor
import HTTP

final class WebSocketManager {
    static let shared = WebSocketManager()
    
    func connectWebSocket() throws {
        ClientConfigManager.registerClientConfig()
        
        guard let token = SlackTokenManager.shared.token else {
            throw BotError.missingSlackConfig
        }
        
        let rtmResponse = try BasicClient.loadRealtimeAPI(token: token)
        
        guard let webSocketURL = rtmResponse.data["url"]?.string else {
            throw BotError.invalidResponse
        }
        
        try WebSocket.connect(to: webSocketURL) { webSocket in
            print("Socket opened: \(webSocketURL)")
            
            webSocket.onText = { webSocket, json in
                let event = try JSON(bytes: json.utf8.array)
                
                guard let type = event["type"]?.string, type == "message" else {
                    return
                }
                
                let message = try SlackMessage(node: event.node)
                try MessageManager.shared.handleMessagesSentToBot(inSocket: webSocket, message: message)
            }
            
            webSocket.onClose = { ws, _, _, _ in
                print("\n[CLOSED]\n")
            }
        }
    }
}
