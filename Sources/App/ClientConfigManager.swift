//
//  ClientConfigManager.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

import TLS
import HTTP
import Transport

final class ClientConfigManager {
    static func registerClientConfig() {
        defaultClientConfig = {
            return try TLS.Config(context: try Context(mode: .client), certificates: .none, verifyHost: false, verifyCertificates: false, cipher: .compat)
        }
    }
}
