//
//  Array+Extension.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//

import Foundation

extension Array {
    func chooseElementAtRandom() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
