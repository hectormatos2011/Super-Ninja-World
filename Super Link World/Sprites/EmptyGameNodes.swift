//
//  EmptyGameNodes.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 3/28/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Pipe: SKSpriteNode {}
class Ground: SKSpriteNode {}
class Block: SKSpriteNode {}

extension Pipe: GameNode {
    func collidedWith(node: GameNode) {
        print("\(type) collided with \(node.type).")
    }
}

extension Ground: GameNode {
    func collidedWith(node: GameNode) {
        print("\(type) collided with \(node.type).")
    }
}

extension Block: GameNode {
    func collidedWith(node: GameNode) {
        print("\(type) collided with \(node.type).")
    }
}