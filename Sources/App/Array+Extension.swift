//
//  Array+Extension.swift
//  GithubShokunin
//
//  Created by yuzushioh on 2016/12/20.
//
//


import Foundation
import libc

extension Array {
    func chooseElementAtRandom() -> Element {
        #if os(Linux)
            let value = UInt32(libc.random() % Int(count))
        #else
            let value = arc4random_uniform(UInt32(count))
        #endif
        
        let index = Int(value)
        
        return self[index]
    }
}
