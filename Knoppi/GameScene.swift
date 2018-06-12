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
    var maxPoint = (x: 1, y: 1)
    
    override func didMove(to view: SKView) {
        /*
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
        
        */
        
        //let pointA = CGPoint(x: center.x, y: center.y + distance)
        //self.addChild(createShapeNode(position: pointA, size: 150, name: "button01", color: .red))
        //self.addChild(createShapeNode(position: pointB, size: 150, name: "button02", color: .blue))
        //let maxPoint = (x: 3, y: 3)
        updateButtons()
        
    }
    
    func updateButtons(){
        for child in self.children{
            child.removeFromParent()
        }
        let center = GetMid()
        let distance: CGFloat = 150
        for i in 1...maxPoint.x {
            for j in 1...maxPoint.y {
                let xOffset = CGFloat(i) * distance
                let yOffset = CGFloat(j) * distance
                let point = CGPoint(x: center.x - xOffset + CGFloat(maxPoint.x + 1) * distance/2, y: center.y - yOffset + CGFloat(maxPoint.y + 1) * distance/2)
                
                self.addChild(createShapeNode(position: point, size: 150, name: "button01", color: .red))
            }
        }
        mainButton = self.children.first as? SKShapeNode
    }
    public func scaleAction (up: Bool){
        var actionName: String
        if up {
            actionName = "scaleUp"
        } else {
            actionName = "scaleDown"
        }
        self.run(SKAction.init(named: actionName)!)
    }
    
    func createShapeNode(position: CGPoint, size: CGFloat, name: String, color: SKColor) -> SKShapeNode {
        //let center = GetMid()
        let randomColor = UIColor.randomColor()
        let node = SKShapeNode(rect: CGRect(x: -size/2, y: -size/2, width: size, height: size))
        node.position = position
        node.fillColor = randomColor
        node.lineWidth = 0
        if maxPoint.x > 1 {
            node.xScale = CGFloat(1.8/Float(maxPoint.x))
            node.yScale = CGFloat(1.8/Float(maxPoint.x))
        }
        return node
        
    }
    
    func touchDown(touch: UITouch) {
        let nodes = self.nodes(at: touch.location(in: self))
        for node in nodes {
            self.run(buttonSound)
            var buttonColor : UIColor = .white
            if touchCounter > 14 {
                buttonColor = .green
                if maxPoint.x == maxPoint.y{
                    maxPoint.x += 1
                } else {
                    maxPoint.y += 1
                }
                touchCounter = 0
                updateButtons()
            } else {
                buttonColor = .white
            }
            if let buttonNode = node as? SKShapeNode {
                buttonNode.fillColor = buttonColor
            }
            touchCounter += 1
            
        }
        
    }
    func touchUp(touch: UITouch) {
        //mainButton?.fillColor = .red
        let nodes = self.nodes(at: touch.location(in: self))
        for node in nodes {
            if let buttonNode = node as? SKShapeNode {
                buttonNode.fillColor = .red
            }
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            touchDown(touch: t)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(touch: t)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(touch: t) }
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
