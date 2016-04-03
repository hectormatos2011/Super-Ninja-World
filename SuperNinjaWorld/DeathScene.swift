//
//  DeathScene.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 4/2/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class DeathScene: SKScene {
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        let labelNode = childNodeWithName(Constants.Scene.deathSceneLabel) as? SKLabelNode
        labelNode?.position = CGPoint(x: view.bounds.width / 2.0, y: view.bounds.height / 2.0)
    }
}
