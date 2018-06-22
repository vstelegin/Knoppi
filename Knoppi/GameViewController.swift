//
//  GameViewController.swift
//  Knoppi
//
//  Created by Chase on 30/05/2018.
//  Copyright © 2018 s0w4. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func randomColor () -> UIColor {
        let colors = [UIColor.blue, UIColor.red, UIColor.green, UIColor.magenta, UIColor.orange, UIColor.yellow]
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[index]
    }
}

class GameViewController: UIViewController {
    var scene: GameScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as! GameScene? {
                // Set the scale mode to scale t7o fit the window
                scene.scaleMode = .aspectFill
                scene.backgroundColor = .black
                // Present the scene
                view.presentScene(scene)
                self.scene = scene
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        
        }
        
    }
    
    @objc func deviceOrientationDidChange(notification : Notification){
        print ("Orientation changed")
        let orientation = UIDevice.current.orientation
        if orientation.isPortrait{
            //self.scene?.scaleAction(up: false)
        }
        if orientation.isLandscape{
            //self.scene?.scaleAction(up: true)
        }
        self.scene!.xScale = CGFloat(0.5)
        self.scene!.yScale = CGFloat(0.5)
    }

    
    
    override var shouldAutorotate: Bool {
        print("Rotating")
        return false
    }
    /*
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .portrait
        }
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
