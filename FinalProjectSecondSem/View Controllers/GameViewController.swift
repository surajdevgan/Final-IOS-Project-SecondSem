//
//  GameViewController.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipefunc(gesture:)) )
        
        swipeDown.direction = .down
        
        self.view.addGestureRecognizer(swipeDown)
        
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipefunc(gesture:)) )
        
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
        
        if let view = self.view as! SKView?, let scene = MenuScene(fileNamed: "MenuScene") {
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            //view.showsPhysics = true
        }
        
        
   
    }
    
    
    @objc func swipefunc(gesture: UISwipeGestureRecognizer){
          
       if gesture.direction == .down{
              
      print("swiped down")
      let theVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController

        self.navigationController?.pushViewController(theVC, animated: true)
          self.removeFromParent()
        self.dismiss(animated: true, completion: nil)

      }
      

  }
    
}
