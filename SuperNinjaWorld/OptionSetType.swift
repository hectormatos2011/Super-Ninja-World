//
//  SpriteType.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/21/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

struct SpriteType: OptionSetType {
    let rawValue: UInt32
    
    static let None     = SpriteType(rawValue: 0)
    static let Player   = SpriteType(rawValue: 1<<0)
    static let Spike    = SpriteType(rawValue: 1<<1)
    static let Plant    = SpriteType(rawValue: 1<<2)
    static let Scene    = SpriteType(rawValue: 1<<3)
    static let Ground   = SpriteType(rawValue: 1<<4)
    static let Pipe     = SpriteType(rawValue: 1<<5)
    static let Block    = SpriteType(rawValue: 1<<6)
}

struct ActionType: OptionSetType {
    let rawValue: UInt32
    
    static let None             = ActionType(rawValue: 0)
    static let Move             = ActionType(rawValue: 1<<0)
    static let Jump             = ActionType(rawValue: 1<<1)
    static let Stationary       = ActionType(rawValue: 1<<2)
    static let FaceLeft         = ActionType(rawValue: 1<<3)
    static let FaceRight        = ActionType(rawValue: 1<<4)
    static let Dying            = ActionType(rawValue: 1<<5)
}

extension SpriteType: OptionSetPrintable {
    static var allTypes: [(element: SpriteType, description: String)] = [
        (.Player, "Player"),
        (.Spike, "Spike"),
        (.Plant, "Plant"),
        (.Scene, "Scene"),
        (.Ground, "Ground"),
        (.Pipe, "Pipe"),
        (.Block, "Block"),
        (.None, "None")
    ]
}

extension ActionType: OptionSetPrintable {
    static var allTypes: [(element: ActionType, description: String)] = [
        (.Move, "Move"),
        (.Jump, "Jump"),
        (.Stationary, "Stationary"),
        (.FaceLeft, "FaceLeft"),
        (.FaceRight, "FaceRight"),
        (.Dying, "Dying"),
        (.None, "None")
    ]
}