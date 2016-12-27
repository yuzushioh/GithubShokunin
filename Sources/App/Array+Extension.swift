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
        #if os(Linux)
            let index = Int(libc.random() % Int(count))
        #else
            let index = Int(arc4random_uniform(UInt32(count)))
        #endif
        
        return self[index]
    }
}
