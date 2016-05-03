//
//  OptionSetType.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 5/3/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import Foundation

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
