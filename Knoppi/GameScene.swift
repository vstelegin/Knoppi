//
//  GameScene.swift
//  Knoppi
//
//  Created by Chase on 30/05/2018.
//  Copyright © 2018 s0w4. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SKScene{
    
    func GetMid()->CGPoint{
        return CGPoint(x: self.frame.midX, y: self.frame.midY)
    }
}

class GameScene: SKScene {
    
    private var touchCounter = 0
    private var level = 1
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var mainButton : SKShapeNode?
    let buttonRect = SKShapeNode(rect: CGRect(x: -150, y: -150, width: 300, height: 300))
    var buttonRect2 = SKShapeNode(rect: CGRect(x: -150, y: -150, width: 300, height: 300))
    let buttonSound = SKAction.playSoundFileNamed("CS_VocoBitB_Hit-02", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        let distance: CGFloat = 200
        let center = GetMid()
        let pointA = CGPoint(x: center.x, y: center.y + distance)
        let pointB = CGPoint(x: center.x, y: center.y - distance)
        buttonRect.position = pointA
        buttonRect.fillColor = .red
        buttonRect.lineWidth = 0
        buttonRect.name = "mainButton"
        self.addChild(buttonRect)
        buttonRect2.position = pointB
        buttonRect2.fillColor = .black
        self.addChild(buttonRect2)
        
        mainButton = self.children.first as? SKShapeNode
        
    }
    
    public func scaleAction (up: Bool){
        var actionName: String
        if up {
            actionName = "scaleUp"
        } else {
            actionName = "scaleDown"
        }
        mainButton?.run(SKAction.init(named: actionName)!)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.run(buttonSound)
        if touchCounter > 14 {
            
        }
        
        mainButton?.fillColor = .white
        touchCounter += 1
        
    }
    func touchUp(atPoint pos : CGPoint) {
        mainButton?.fillColor = .red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    /*
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    */
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
