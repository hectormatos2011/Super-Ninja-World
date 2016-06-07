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
    var action: ActionType = .None
    weak var delegate: DeathDelegate?
    lazy var actions: [ActionType : SKAction] = self.loadActions()

    var multiplier: CGFloat {
        if action.contains(.Move) {
            return action.contains(.FaceLeft) ? -1 : 1
        } else {
            return 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
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
        let newAction: ActionType = [.Move, .FaceLeft]
        
        guard action != .Dying && !action.contains([.Move, .FaceLeft]) else { return }
        guard let moveLeftAction = actions[newAction] else { return }
        
        removeAllActions()
        runAction(moveLeftAction)
        
        action.remove([.Stationary, .FaceRight])
        action.insert(newAction)
    }
    
    func moveRight() {
        let newAction: ActionType = [.Move, .FaceRight]
        
        guard action != .Dying && !action.contains([.Move, .FaceRight]) else { return }
        guard let moveRightAction = actions[newAction] else { return }
        
        removeAllActions()
        runAction(moveRightAction)
        
        action.remove([.Stationary, .FaceLeft])
        action.insert(newAction)
    }
    
    func jump() {
        let newAction: ActionType = action.contains(.FaceLeft) ? [.FaceLeft, .Jump] : [.FaceRight, .Jump]
        
        guard !action.contains(.Dying) && !action.contains(.Jump) else { return }
        guard let jumpAction = actions[newAction] else { return }
        
        removeAllActions()
        runAction(jumpAction)
        action.insert(newAction)
        
        physicsBody?.velocity.dy = Constants.Player.verticalJumpSpeed
    }
    
    func stopMoving() {
        let newAction: ActionType = action.contains(.FaceLeft) ? [.FaceLeft, .Stationary] : [.FaceRight, .Stationary]
        
        guard action != .Dying && !action.contains([.Stationary]) else { return }
        guard let stopAction = actions[newAction] else { return }
        
        removeAllActions()
        runAction(stopAction)
        
        action.remove([.Move])
        action.insert(newAction)
    }
}

// MARK: Action Loading Functions
extension Player {
    func loadActions() -> [ActionType : SKAction] {
        let typesWithSKSActions: [ActionType] = [
            [.FaceLeft, .Stationary],
            [.FaceRight, .Stationary],
            [.FaceLeft, .Jump],
            [.FaceRight, .Jump],
            [.FaceLeft, .Move],
            [.FaceRight, .Move],
        ]
        
        let loadedActions = typesWithSKSActions.reduce([ActionType : SKAction]()) {
            var newActions = $0
            newActions[$1] = SKAction(named: String($1))
            return newActions
        }
        
        return loadedActions
    }
}

//MARK: GameNode Protocol Functions
extension Player: GameNode {
    func setUpBitMasks() {
        categorySetType = .Player
        contactTestSetType = [.Spike, .Plant, .Block, .Pipe, .Ground]
        collisionSetType = [.Ground, .Block, .Scene, .Pipe]
    }
    
    func collidedWith(node: GameNode) {
        guard let sprite = node.node as? SKSpriteNode else { return }
        
        if (node.categorySetType == .Spike || node.categorySetType == .Plant) && action != .Dying {
            action = .Dying
            collisionSetType = .None
            physicsBody?.velocity = CGVector(dx: 0.0, dy: Constants.Player.maxSpeed)
            
            delegate?.andThatsAllSheWrote()
        } else if action.contains(.Jump) {
            if frame.maxY > sprite.position.y {
                action.remove(.Jump)
            }
        }
    }
}
