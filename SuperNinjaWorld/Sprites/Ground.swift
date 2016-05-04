//
//  Ground.swift
//  Super Ninja World
//
//  Created by Hector Matos on 4/2/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpBitMasks()
    }
}

//MARK: GameNode Protocol Functions
extension Ground: GameNode {
    func setUpBitMasks() {
        //REPLACE WITH BITMASK SETUP CODE
    }
}
