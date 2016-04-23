//
//  Player.swift
//  Super Ninja World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

protocol DeathDelegate: class {
    func andThatsAllSheWrote()
}

class Player: SKSpriteNode {
    weak var delegate: DeathDelegate?

    var multiplier: CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(currentTime: CFTimeInterval) {
        guard var velocity = physicsBody?.velocity else {
            return
        }
        
        velocity.dx += Constants.Player.velocityIncrement * multiplier
        
        if velocity.dx < 0 {
            velocity.dx = max(velocity.dx, -Constants.Player.maxSpeed)
        } else {
            velocity.dx = min(velocity.dx, Constants.Player.maxSpeed)
        }
        
        physicsBody?.velocity = velocity
    }
}

// MARK: Key Commands!
extension Player {
    func moveLeft() {
    }
    
    func moveRight() {
    }
    
    func jump() {
    }
    
    func stopMoving() {
    }
}

//MARK: GameNode Protocol Functions
extension Player: GameNode {
}
