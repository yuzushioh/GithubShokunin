//
//  MessageManager.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/18/16.
//
//

import Vapor

final class MessageManager {
    static let shared = MessageManager()
    
    private var botName = drop.config["bot-config", "bot_name"]?.string
    
    enum MessageContent {
        case requestReview(prNumber: String)
        case commandLine
        case unknown
        
        init(text: String) {
            guard text.hasPrefix("<@") else {
                self = .unknown
                return
            }
            
            if let prNumber = text.extractSubstringFromCharacter(character: "#"), text.hasPrefix("<@"), text.contains("review")  {
                self = .requestReview(prNumber: prNumber)
                return
            }
            
            if text.contains("--help") {
                self = .commandLine
                return
            }
            
            self = .unknown
        }
    }
    
    func handleMessagesSentToBot(inSocket socket: WebSocket, message: SlackMessage) throws {
        guard let userId = message.text.extractString(fromCharacter: "@", toCharacter: ">") else {
            return
        }
        
        let slackUser = try SlackManager.shared.getSlackUserByUserId(userId)
        
        guard slackUser.name == botName else {
            return
        }
        
        let content = MessageContent(text: message.text)
        let responseText: String
        
        switch content {
        case .requestReview(let prNumber):
            let pullRequest = try GithubManager.shared.getPullRequestByNumber(prNumber)
            
            if pullRequest.labels.contains("WIP") {
                try GithubManager.shared.removeWIPLabelFromPullRequest(pullRequest)
            }
            
            guard let reviewer = try GithubManager.shared.choosePullrequestReviewerAtRondom(authorName: pullRequest.author.name) else {
                responseText = "There is no one in the team"
                break
            }
            
            let result = try GithubManager.shared.requestReviewToPullRequest(pullRequest, reviewer: reviewer)
            
            switch result {
            case .success:
                responseText = "Assigned #\(pullRequest.number)「\(pullRequest.title)」to \(reviewer.name) :\(pullRequest.url)"
                
            case .failure:
                responseText = "Error ocurred"
            }
            
        case .commandLine:
            let commandLineList = "@Bot <review #PR>"
            responseText = commandLineList
            
        case .unknown:
            return
        }
        
        let response = SlackMessage(to: message.channel, text: responseText)
        return try socket.send(response)
    }
}
