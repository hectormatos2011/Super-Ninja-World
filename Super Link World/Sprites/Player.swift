//
//  Player.swift
//  Super Link World
//
//  Created by Hector Matos on 3/17/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

enum ActionType: String {
    case StationaryLeft
    case StationaryRight
    case MoveLeft
    case MoveRight
    case JumpLeft
    case JumpRight
    
    static var allActionTypes: [ActionType] {
        return [
            .StationaryLeft, .StationaryRight, .MoveLeft, .MoveRight, .JumpLeft, .JumpRight
        ]
    }
}

class Player: SKSpriteNode {
    var pivoting = false
    var movingLeft = false
    var movingRight = false
    var jumping = false
    var dying = false
    
    lazy var actions: Dictionary<ActionType, SKAction> = self.loadActions()

    var shouldMove: Bool {
        return (movingRight && !movingLeft) || (movingLeft && !movingRight)
    }
    var targetVelocity: CGFloat {
        let multiplier: CGFloat
        if shouldMove && movingLeft {
            multiplier = -1
        } else if shouldMove && movingRight {
            multiplier = 1
        } else {
            multiplier = 0
        }
        return 10.0 * multiplier
    }
    let maxSpeed: CGFloat = 300.0
    
    func updatePlayer(currentTime: CFTimeInterval) {
        guard var velocity = physicsBody?.velocity else {
            return
        }
        
        if shouldMove {
            if fabs(targetVelocity) > 1.0 {
                velocity.dx += targetVelocity
            }
            
            if velocity.dx > maxSpeed {
                velocity.dx = maxSpeed
            } else if velocity.dx < -maxSpeed {
                velocity.dx = -maxSpeed
            }
            if pivoting {
                pivoting = false
                
                if velocity.dx.isSignMinus {
                    velocity.dx = max(velocity.dx, -75.0)
                } else {
                    velocity.dx = min(velocity.dx, 75.0)
                }
            }
        }
        
        physicsBody?.velocity = velocity
    }
}

// MARK: Key Commands!
extension Player {
    func moveLeft() {
        guard !dying else { return }
        
        if !movingLeft {
            //If you are already moving left then there's no need to repeat the run action function
            removeAllActions()
            runAction(actions[.MoveLeft]!)
            pivoting = true
        }
        
        movingLeft = true
        movingRight = false
    }
    
    func moveRight() {
        guard !dying else { return }
        
        if !movingRight {
            //If you are already moving right then there's no need to repeat the run action function
            removeAllActions()
            runAction(actions[.MoveRight]!)
            pivoting = true
        }
        
        movingLeft = false
        movingRight = true
    }
    
    func jump() {
        guard !dying && !jumping else { return }
        
        removeAllActions()
        if movingLeft {
            runAction(actions[.JumpLeft]!)
        } else {
            runAction(actions[.JumpRight]!)
        }
        
        physicsBody?.velocity.dy += 700.0
        jumping = true
    }
}

// MARK: Action Loading Functions
extension Player {
    func loadActions() -> [ActionType : SKAction] {
        var actions = [ActionType : SKAction]()
        for actionType in ActionType.allActionTypes {
            if let action = SKAction(named: actionType.rawValue) {
                actions[actionType] = action
            }
        }
        
        return actions
    }
}

extension Player: GameNode {
    func collidedWith(node: GameNode) {
        if node.type == .Enemy && !dying {
            dying = true
            collisionBitMask = .None
            physicsBody?.velocity = CGVector(dx: 0.0, dy: 300.0)
        } else if jumping {
            if movingLeft {
                movingLeft = false
                moveLeft()
            } else {
                movingRight = false
                moveRight()
            }
            jumping = false
        }
    }
}
