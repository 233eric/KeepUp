//
//  GameScene.swift
//  SpriteGame
//
//  Created by Eric Thai on 2018-02-05.
//  Copyright © 2018 Eric Thai. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate  {
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var starfield:SKEmitterNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView){
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        starfield.zPosition = -1
        
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "Score") as! SKLabelNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 43, dy: 55))
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "Ball" && bodyBName == "Paddle" || bodyAName == "Paddle" && bodyBName == "Ball" {
            if bodyAName == "Paddle" {
                score += 1
            }
            else if bodyBName == "Paddle" {
                score += 1
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (ball.position.y < paddle.position.y) {
            scoreLabel.text = "YOU LOSE"
            self.view?.isPaused = true
        }
    }
    
    
    
    
    
}
