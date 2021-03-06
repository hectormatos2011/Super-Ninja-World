//
//  Enemy.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Spike: SKSpriteNode {
    var directionMultiplier: CGFloat = -1.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
    }
    
    func reverseSpikeDirection() {
        let rotateAction = SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(GLKMathDegreesToRadians(Constants.Enemy.spikeRotationAngle * Float(multiplier))), duration: 0.1))
        removeAllActions()
        runAction(rotateAction)
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
        position.x += Constants.Enemy.xPositionIncrement * directionMultiplier
    }
    
    func collidedWith(node: GameNode) {
        if node.categorySetType != .Player {
            directionMultiplier *= -1.0
            reverseSpikeDirection()
        }
    }
}
