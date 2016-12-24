//
//  HTTPClient+RTMAPI.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

import Vapor
import HTTP

extension HTTP.Client {
    static func loadRealtimeAPI(token: String, simpleLatest: Bool = true, excludesUnreads: Bool = true) throws -> HTTP.Response {
        let headers: [HeaderKey: String] = ["Accept": "application/json; charset=utf-8"]
        let query: [String: CustomStringConvertible] = [
            "token": token,
            "simple_latest": simpleLatest.queryInt,
            "no_unreads": excludesUnreads.queryInt
        ]
        
        return try get(
            SlackAPI.webSocket,
            headers: headers,
            query: query
        )
    }
}

extension Bool {
    var queryInt: Int {
        return self ? 1 : 0
    }
}
