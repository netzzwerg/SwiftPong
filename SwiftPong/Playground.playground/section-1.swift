// Example of using SpriteKit in a Playground by Stede Troisi
// Copyright 2014 Trolieb LLC.
//
// Simply click on the arrow to the right of var view = SKView(...

import Cocoa
import SpriteKit
import XCPlayground


class MyScene: SKScene {
    var _previousTime = 0.0
    var _currentTime = 0.0
    var _deltaTime = 0.0
    
    override func didMoveToView(view: SKView!) {
        var sprite1 = SKSpriteNode(color: NSColor.greenColor(), size: CGSize(width: 50.0, height: 50.0))
        sprite1.name = "block"
        sprite1.position = CGPoint(x: 50.0, y: 50.0)
        self.addChild(sprite1)
    }
    
    override func update(currentTime: NSTimeInterval)  {
        if _previousTime == 0.0 { _previousTime = currentTime }
        _deltaTime = currentTime - _previousTime
        _previousTime = currentTime
        var block = self.childNodeWithName("block")
        block.position = CGPoint(x: block.position.x + (20.0 * _deltaTime), y: block.position.y + (20.0 * _deltaTime))
    }
}

var view = SKView(frame:NSRect(x: 0.0, y: 0.0, width: 1024, height: 768))
XCPShowView("View", view)

var scene = MyScene(size: CGSize(width: 1024.0, height: 768.0))
view.presentScene(scene)
scene.backgroundColor = NSColor.blackColor()