//
//  Loopable+Uala.swift
//  Uala
//
//  Created by Jose Chourio on 11/1/20.
//  Copyright © 2020 Jose Chourio. All rights reserved.
//

import Foundation

protocol Loopable {
    func allProperties() throws -> [String: String?]
}

extension Loopable {
    func allProperties() throws -> [String: String?] {

        var result: [String: String?] = [:]

        let mirror = Mirror(reflecting: self)

        // Optional check to make sure we're iterating over a struct or class
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            throw NSError()
        }

        for (property, value) in mirror.children {
            guard let property = property else {
                continue
            }
            
            result[property] = value as? String
        }
        return result
    }
}
