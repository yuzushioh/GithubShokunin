//
//  String+Extension.swift
//  GithubShokunin
//
//  Created by yuzushioh on 12/18/16.
//
//

import Foundation

extension String {
    func extractString(fromCharacter from: String, toCharacter to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    func extractSubstringFromCharacter(character: String) -> String? {
        guard let fromIndex = range(of: character) else {
            return nil
        }
        
        return substring(from: fromIndex.upperBound)
    }
}
