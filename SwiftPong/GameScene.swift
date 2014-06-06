//
//  GameScene.swift
//  SwiftPong
//
//  Created by Béla Varga on 05.06.14.
//  Copyright (c) 2014 Béla Varga. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let spriteBall = SKSpriteNode(imageNamed:"ball")
    var doAnimation = true;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // default settings
        view.showsFPS = false;
        view.showsNodeCount = false;
        
        // setup physics
        self.physicsWorld.gravity = CGVectorMake( 0, 0 )
        
        // set background color
        //self.backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        
        // set start position
        //spriteBall.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        spriteBall.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        
        //spriteBall.position = CGPoint(x:0.0 + 25, y:725.0 - 25) // left top position
        //spriteBall.position = CGPoint(x:1024.0 - 25, y:725.0 - 25) // right top position
        //spriteBall.position = CGPoint(x:0.0 + 25, y:45.0 + 25) // left bottom position
        //spriteBall.position = CGPoint(x:1024.0 - 25, y:45.0 + 25) // right bottom position
        
        spriteBall.xScale = 0.25
        spriteBall.yScale = 0.25
        
        
        // set physics
        spriteBall.physicsBody = SKPhysicsBody(circleOfRadius: spriteBall.size.height / 2.0)
        spriteBall.physicsBody.dynamic = true
        spriteBall.physicsBody.allowsRotation = false
        
        self.addChild(spriteBall)
        
        
        // set start move
        spriteBall.physicsBody.velocity = CGVectorMake(10, 60)
        spriteBall.physicsBody.applyImpulse(CGVectorMake(60, 120))
        
        
        let stageWidth = self.size.width
        let stageHeight = self.size.height
        
        println(stageWidth)
        println(stageHeight)
        
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if(doAnimation) {
                self.doAnimation = false;
            } else {
                self.doAnimation = true;
            }
            
            println(location.x)
            println(location.y)
            println(self.convertPointFromView(CGPoint(x:location.x, y:location.y)))
            println(self.convertPointToView(CGPoint(x:location.x, y:location.y)))
            
        }
    }
    
    func checkCollision(ballPosX:CGFloat, ballPosY:CGFloat, ballRadius:CGFloat, stageWidth:CGFloat, stageHeight:CGFloat) {
        
        let dx = ballPosX - ballRadius
        let sx = ballPosX + ballRadius
        let dy = ballPosY - ballRadius
        let sy = ballPosY + ballRadius
        
        // horizontal wall hit
        if (dx < 0) {
            spriteBall.position.x = 0 + ballRadius;
            spriteBall.physicsBody.velocity.dx *= -1;
            println("wall hit left")
        } else if (sx > 1024) {
            spriteBall.position.x = 1024 - ballRadius;
            spriteBall.physicsBody.velocity.dx *= -1;
            println("wall hit right")
        }
        
        // vertical wall hit
        if (dy > 725 - 50) {
            spriteBall.position.y = 725 - 50 + ballRadius;
            spriteBall.physicsBody.velocity.dy *= -1;
            println("wall hit top")
        } else if (dy < 45.0) {
            spriteBall.position.y = 45 + ballRadius;
            spriteBall.physicsBody.velocity.dy *= -1;
            println(spriteBall.position.y)
            println("wall hit bottom")
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let stageWidth = self.size.width
        let stageHeight = self.size.height
        let ballRadius:CGFloat = spriteBall.size.height / 2.0
        
        if(doAnimation) {
            self.checkCollision(spriteBall.position.x, ballPosY: spriteBall.position.y, ballRadius: 25, stageWidth: stageHeight, stageHeight: stageWidth)
        }
    }
    
}
