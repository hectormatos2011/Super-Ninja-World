//
//  Goomba.swift
//  Super Link World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

enum EnemyType {
    case Goomba
    case PirahnaPlant
}

class Enemy: SKSpriteNode {
    var multiplier: CGFloat = -1.0
    func updateEnemy(currentTime: CFTimeInterval) {
        position.x += 2.0 * multiplier
    }
}

extension Enemy: GameNode {
    func collidedWith(node: GameNode) {
        if node.type != .Player {
            multiplier *= -1.0
            
            let rotateAction = SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(GLKMathDegreesToRadians(-30.0 * Float(multiplier))), duration: 0.1))
            removeAllActions()
            runAction(rotateAction)
        }
    }
}
