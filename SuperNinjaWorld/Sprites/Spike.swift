//
//  Enemy.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Spike: SKSpriteNode {
    var multiplier: CGFloat = -1.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
    }
}

//MARK: GameNode Protocol Functions
extension Spike: GameNode {
    func setUpBitMasks() {
        categorySetType = .Spike
        contactTestSetType = [.Pipe, .Scene]
        collisionSetType = .Ground
    }
    
    func update(currentTime: CFTimeInterval) {
        position.x += 2.0 * multiplier
    }
    
    func collidedWith(node: GameNode) {
        if node.categorySetType != .Player {
            multiplier *= -1.0
            
            let rotateAction = SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(GLKMathDegreesToRadians(-30.0 * Float(multiplier))), duration: 0.1))
            removeAllActions()
            runAction(rotateAction)
        }
    }
}
