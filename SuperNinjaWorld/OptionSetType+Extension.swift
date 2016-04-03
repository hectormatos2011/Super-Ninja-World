//
//  OptionSetType+Extension.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 4/2/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

protocol OptionSetPrintable: CustomStringConvertible, CustomDebugStringConvertible {
    associatedtype Element = Self
    static var allTypes: [Element] { get }
    static var descriptions: [String] { get }
}

extension OptionSetPrintable where Self: OptionSetType, Self.Element: OptionSetType, Self.Element.RawValue == UInt32 {
    var description: String {
        return description(debug: false)
    }
    var debugDescription: String {
        return description(debug: true)
    }
    
    func description(debug debug: Bool) -> String {
        var description = ""
        for type in Self.allTypes {
            if contains(type) && type.rawValue != 0 {
                let index = Int(log2(Float(type.rawValue)))
                let typeDescription = Self.descriptions[index]
                description += (description.isEmpty || !debug) ? typeDescription : ", \(typeDescription)"
            }
        }
        return description
    }
}

// MARK: Hashable Protocol
extension ActionType: Hashable {
    var hashValue: Int { return Int(rawValue) }
}

// MARK: Comparable Protocol
extension SpriteType: Comparable {}
func < (lhs: SpriteType, rhs: SpriteType) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

func == (lhs: SpriteType, rhs: SpriteType) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
