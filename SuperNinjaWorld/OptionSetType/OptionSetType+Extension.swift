//
//  OptionSetType+Extension.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 5/3/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import Foundation

// MARK: Hashable Protocol
extension ActionType: Hashable {
    var hashValue: Int { return Int(rawValue) }
}
