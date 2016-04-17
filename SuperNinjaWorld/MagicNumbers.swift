//
//  MagicNumbers.swift
//  SuperNinjaWorld
//
//  Created by Hector Matos on 4/2/16.
//  Copyright © 2016 Hector Matos. All rights reserved.
//

import CoreGraphics

enum Constants {
    enum Scene {
        enum Button {
            static let size: CGFloat = 60.0
            static let margin: CGFloat = 20.0
            static let midMargin: CGFloat = 15.0
            static let zPosition: CGFloat = 1000.0

            static let aImageFileName = "AButton"
            static let leftImageFileName = "LeftButton"
            static let rightImageFileName = "RightButton"
        }
        static let deathSceneLabel = "GameOverLabel"
        static let deathSceneTransitionDuration = 3.0
    }
    enum Player {
        static let maxSpeed: CGFloat = 300.0
        static let velocityIncrement: CGFloat = 10.0
        static let verticalJumpSpeed: CGFloat = 700.0
    }
    enum Enemy {
        static let spikeRotationAngle: Float = -30.0
        static let xPositionIncrement: CGFloat = 2.0
    }
}