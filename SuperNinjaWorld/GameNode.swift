//
//  GameNode.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 4/2/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

protocol GameNode: class {
    var node: SKNode { get }

    func update(currentTime: NSTimeInterval)
    func collidedWith(node: GameNode)
}

extension GameNode where Self: SKNode {
    var node: SKNode { return self }

    func update(currentTime: NSTimeInterval) {}
    func collidedWith(node: GameNode) {
    }
}
