//
//  SpriteType.swift
//  Super Link World
//
//  Created by Hector Matos on 3/21/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

struct SpriteType: OptionSetType {
    let rawValue: UInt32
    
    static let None       = SpriteType(rawValue: 0b0)
    static let Player     = SpriteType(rawValue: 0b1)
    static let Enemy      = SpriteType(rawValue: 0b10)
    static let Scene      = SpriteType(rawValue: 0b100)
    static let Ground     = SpriteType(rawValue: 0b1000)
    static let Pipe       = SpriteType(rawValue: 0b10000)
    static let Block      = SpriteType(rawValue: 0b100000)
    
    private static var allTypes: [SpriteType] = [
        .None, .Player, .Enemy, .Scene, .Ground, .Pipe, .Block
    ]
    private static var allDescriptions: [String] = [
        "None", "Player", "Enemy", "Scene", "Ground", "Pipe", "Block"
    ]
}

protocol GameNode: class {
    var node: SKNode? { get }
    var type: SpriteType { get set }
    var contactTestBitMask: SpriteType { get set }
    var collisionBitMask: SpriteType { get set }

    func collidedWith(node: GameNode)
}

extension GameNode where Self: SKNode {
    var node: SKNode? { return self }
    
    var type: SpriteType {
        get { return SpriteType(rawValue: physicsBody?.categoryBitMask ?? 1) }
        set { physicsBody?.categoryBitMask = newValue.rawValue }
    }

    var contactTestBitMask: SpriteType {
        get { return SpriteType(rawValue: physicsBody?.contactTestBitMask ?? 1) }
        set { physicsBody?.contactTestBitMask = newValue.rawValue }
    }
    
    var collisionBitMask: SpriteType {
        get { return SpriteType(rawValue: physicsBody?.collisionBitMask ?? 1) }
        set { physicsBody?.collisionBitMask = newValue.rawValue }
    }
}

extension SpriteType: Comparable {}
func < (lhs: SpriteType, rhs: SpriteType) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

func == (lhs: SpriteType, rhs: SpriteType) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

extension SpriteType: CustomStringConvertible {
    var description: String {
        var description = ""
        for type in SpriteType.allTypes {
            if contains(type) {
                let index = Int(log2(Float(type.rawValue)))
                let typeDescription = SpriteType.allDescriptions[index]
                description += description.isEmpty ? typeDescription : ", \(typeDescription)"
            }
        }
        return description
    }
}