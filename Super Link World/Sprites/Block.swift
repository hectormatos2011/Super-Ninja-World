//
//  Block.swift
//  Super Link World
//
//  Created by Hector Matos on 3/26/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Block: SKSpriteNode {}

extension Block: GameNode {
    func collidedWith(node: GameNode) {
        print("\(type) collided with \(node.type).")
    }
}
