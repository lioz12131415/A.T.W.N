//
//  StarFallSKScene.swift
//  AroundTheWorldNews
//
//  Created by lioz balki on 23/11/2018.
//  Copyright © 2018 lioz balki. All rights reserved.
//

import Foundation
import SpriteKit

//a scene in the game.
class Night: SKScene{
    
    var from = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        createStarLayers()
    }
    
    func createStarLayers() {
        //A layer of a star field
        let starfieldNode = SKNode()
        
        starfieldNode.name = "starfieldNode"
        starfieldNode.addChild(starfieldEmitterNode(speed: -48, lifetime: size.height / 23, scale: 0.2, birthRate: 1, color: SKColor.lightGray))
        addChild(starfieldNode)
        
        //A second layer of stars
        var emitterNode = starfieldEmitterNode(speed: -32, lifetime: size.height / 10, scale: 0.14, birthRate: 2, color: SKColor.gray)
        emitterNode.zPosition = -10
        starfieldNode.addChild(emitterNode)
        
        //A third layer
        emitterNode = starfieldEmitterNode(speed: -20, lifetime: size.height / 5, scale: 0.1, birthRate: 5, color: SKColor.darkGray)
        starfieldNode.addChild(emitterNode)
                
    }
}



extension Night{
    //animation func
    func starfieldEmitterNode(speed: CGFloat, lifetime: CGFloat, scale: CGFloat, birthRate: CGFloat, color: SKColor) -> SKEmitterNode {
        
        let star = SKLabelNode(fontNamed: "Helvetica")
        star.fontSize = 100.0
        star.text = "∙"
        
        let textureView = SKView()
        
        let texture = textureView.texture(from: star)
        texture!.filteringMode = .nearest
        
        let emitterNode = SKEmitterNode()
        
        emitterNode.particleTexture = texture
        emitterNode.particleBirthRate = birthRate
        emitterNode.particleColor = color
        emitterNode.particleLifetime = lifetime
        emitterNode.particleSpeed = speed
        emitterNode.particleScale = scale
        emitterNode.particleColorBlendFactor = 1
        emitterNode.position = CGPoint(x: frame.midX, y: frame.maxY)
        emitterNode.particlePositionRange = CGVector(dx: frame.maxY, dy: 0)
        emitterNode.particleSpeedRange = 16.0
        
        //Rotates the stars
        emitterNode.particleAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.rotate(byAngle: CGFloat(-M_PI_4), duration: 1),
            SKAction.rotate(byAngle: CGFloat(M_PI_4), duration: 1)]))
        
        //Causes the stars to twinkle
        let twinkles = 20
        let colorSequence = SKKeyframeSequence(capacity: twinkles*2)
        let twinkleTime = 1.0 / CGFloat(twinkles)
        
        for i in 0..<twinkles {
            colorSequence.addKeyframeValue(SKColor.white,time: CGFloat(i) * 2 * twinkleTime / 2)
            colorSequence.addKeyframeValue(SKColor.white, time: (CGFloat(i) * 2 + 1) * twinkleTime / 2)
        }
        emitterNode.particleColorSequence = colorSequence
        
        emitterNode.advanceSimulationTime(TimeInterval(lifetime))
        
        print()
        
        return emitterNode
    }
}

class StarFallSKScene{
    
    static func set(view: SKView){
        
        let v = view as SKView
        let size = v.frame.size
        let scene = Night(size: size)
        
        scene.backgroundColor = UIColor.black
        
        v.presentScene(scene)
    }
    
    static func remove(view: SKView){
        
        let v = view as SKView
        let size = v.frame.size
        let scene = Night(size: size)
    
        scene.removeFromParent()
    }
}
