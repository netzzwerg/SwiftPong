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
        self.backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        // set start position
        spriteBall.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        spriteBall.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        spriteBall.xScale = 0.25
        spriteBall.yScale = 0.25
        
        // set physics
        spriteBall.physicsBody = SKPhysicsBody(circleOfRadius: spriteBall.size.height / 2.0)
        spriteBall.physicsBody.dynamic = true
        spriteBall.physicsBody.allowsRotation = false
        
        self.addChild(spriteBall)
        
        println(spriteBall.size.height / 2.0)
        println(spriteBall.size.width / 2.0)
        
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
      
        }
    }
   
    func checkCollision(ballPosX:CGFloat, ballPosY:CGFloat, ballRadius:CGFloat, stageWidth:CGFloat, stageHeight:CGFloat) {
        
        let dx = ballPosX - ballRadius
        let sx = ballPosX + ballRadius
        let dy = ballPosY - ballRadius
        let sy = ballPosY + ballRadius
        
        // horizontal wall hit
        if (sx < 224.0) {
            spriteBall.position.x = 224.0 + ballRadius;
            spriteBall.physicsBody.velocity.dx *= -1;
            println("wall hit left")
        } else if (sx > stageWidth) {
            spriteBall.position.x = stageWidth - ballRadius;
            spriteBall.physicsBody.velocity.dx *= -1;
            println("wall hit right")
        }
        
        // vertical wall hit
        if (dy > 738) {
            spriteBall.position.y = 738 + ballRadius;
            spriteBall.physicsBody.velocity.dy *= -1;
            println("wall hit top")
        } else if (dy < 0.0) {
            spriteBall.position.y = ballRadius;
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
            self.checkCollision(spriteBall.position.x, ballPosY: spriteBall.position.y, ballRadius: 30.0, stageWidth: stageHeight, stageHeight: stageWidth)
        }
    }

}
