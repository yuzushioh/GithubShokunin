//
//  GetPullRequestURLBuilder.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//


final class URLBuilder {
    struct GetPullRequest {
        let owner: String
        let repositoryName: String
        let prNumber: String
        
        var url: String {
            return GithubAPI.base
                .appending("/repos")
                .appending("/\(owner)")
                .appending("/\(repositoryName)")
                .appending("/issues")
                .appending("/\(prNumber)")
        }
    }
    
    struct GetTeamMembers {
        let teamId: String
        
        var url: String {
            return GithubAPI.base
                .appending("/teams")
                .appending("/\(teamId)")
                .appending("/members")
        }
    }
    
    struct AssignReviewer {
        let owner: String
        let repositoryName: String
        let prNumber: String
        
        var url: String {
            return GithubAPI.base
                .appending("/repos")
                .appending("/\(owner)")
                .appending("/\(repositoryName)")
                .appending("/pulls")
                .appending("/\(prNumber)")
                .appending("/requested_reviewers")
        }
    }
    
    struct RemoveLabel {
        let owner: String
        let repositoryName: String
        let labelName: String
        
        var url: String {
            return GithubAPI.base
                .appending("/repos")
                .appending("/\(owner)")
                .appending("/\(repositoryName)")
                .appending("/labels")
                .appending("/\(labelName)")
        }
    }
}
