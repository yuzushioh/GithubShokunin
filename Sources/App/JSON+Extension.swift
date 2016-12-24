//
//  JSON+Extension.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/17/16.
//
//

import Fluent
import JSON

extension JSON {
    static func parseString(_ str: String) throws -> JSON {
        return try JSON(bytes: str.utf8.array)
    }
}
