//
//  GithubManager.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//

import Vapor

final class GithubManager {
    static let shared = GithubManager()
    
    private var token: String? {
        return drop.config["github-config", "github_token"]?.string
    }
    
    private var ownerName: String? {
        return drop.config["github-config", "owner_name"]?.string
    }
    
    private var repositoryName: String? {
        return drop.config["github-config", "repo_name"]?.string
    }
    
    private var reviewTeamId: String? {
        return drop.config["github-config", "review_team_id"]?.string
    }
    
    enum Result {
        case success
        case failure
    }
    
    func getPullRequestByNumber(_ number: String) throws -> PullRequest {
        let config = try buildGithubConfig()
        
        let url = URLBuilder.GetPullRequest(owner: config.ownerName, repositoryName: config.repositoryName, prNumber: number).url
        let response = try drop.client.get(
            url,
            headers: ["Accept": "application/json; charset=utf-8", "Authorization": "token \(config.token)"]
        )
        
        guard let json = response.json else {
            throw BotError.invalidResponse
        }
        
        return try PullRequest(node: json.node)
    }
    
    func requestReviewToPullRequest(_ pullRequest: PullRequest, reviewer: GithubUser) throws -> Result {
        let config = try buildGithubConfig()
        
        let url = URLBuilder.AssignReviewer(owner: config.ownerName, repositoryName: config.repositoryName, prNumber: String(pullRequest.number)).url
        let body = JSON(["reviewers": [Node.string(reviewer.name)]]).makeBody()
        
        do {
            let _ = try drop.client.post(
                url,
                headers: ["Accept": "application/vnd.github.black-cat-preview+json; charset=utf-8;", "Authorization": "token \(config.token)"],
                body: body)
        } catch {
            return .failure
        }
        
        return .success
    }
    
    func removeWIPLabelFromPullRequest(_ pullRequest: PullRequest) throws {
        let config = try buildGithubConfig()
        let url = URLBuilder.RemoveLabel(owner: config.ownerName, repositoryName: config.repositoryName, labelName: "WIP").url
        let _ = try drop.client.delete(url, headers: ["Accept": "application/json; charset=utf-8", "Authorization": "token \(config.token)"])
    }
    
    func choosePullrequestReviewerAtRondom(authorName: String) throws -> GithubUser? {
        guard let reviewTeamId = reviewTeamId,
            let token = token else {
            throw BotError.missingGithubConfig
        }
        
        let url = URLBuilder.GetTeamMembers(teamId: reviewTeamId).url
        guard let memberJson = try drop.client.get(url, headers: ["Accept": "application/json; charset=utf-8", "Authorization": "token \(token)"]).json else {
            throw BotError.invalidResponse
        }
        
        let reviewTeam = try ReviewTeam(node: memberJson.node)
        let reviewMembers = reviewTeam.members.filter { $0.name != authorName }
        
        return reviewMembers.chooseElementAtRandom()
    }
    
    private struct GithubConfig {
        let token: String
        let ownerName: String
        let repositoryName: String
    }
    
    private func buildGithubConfig() throws -> GithubConfig {
        guard let ownerName = ownerName,
            let repositoryName = repositoryName,
            let token = token else {
                throw BotError.missingGithubConfig
        }
        
        return GithubConfig(token: token, ownerName: ownerName, repositoryName: repositoryName)
    }
}
