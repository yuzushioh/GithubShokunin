//
//  SlackAPI.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

final class SlackAPI {
    private static let base = "https://slack.com/api/"
    
    static let webSocket = base + "rtm.start"
    static let userInformation = base + "users.info"
}
