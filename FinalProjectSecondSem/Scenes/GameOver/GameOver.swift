//
//  GameOver.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//

import SpriteKit
import UIKit

class GameOver: SKScene {
    
    
    var starField: SKEmitterNode!
    var scoreNumberLabel: SKLabelNode!
    var newGameButtonNode: SKSpriteNode!
    var menuButtonNode: SKSpriteNode!
    var userdefaults = UserDefaults()
    
    var score: Int = 0
    var students = [User] ()
    var useremail = ""
    
    override func didMove(to view: SKView) {
        setupStarField()
        setupScoreNumberLabel()
        setupNewGameButton()
        setupMenuButtonNode()
    }
    
    func setupMenuButtonNode() {
        menuButtonNode = childNode(withName: "menuButton") as? SKSpriteNode
        menuButtonNode.texture = SKTexture(imageNamed: "home")
        
      
    }
    
    func setupStarField() {
        starField = self.childNode(withName: "starField") as? SKEmitterNode
        starField.advanceSimulationTime(10)
    }
    
    func setupScoreNumberLabel() {
        scoreNumberLabel = self.childNode(withName: "scoreNumberLabel") as? SKLabelNode
        scoreNumberLabel.text = "\(score)"
        
        useremail =  userdefaults.value(forKey: "email") as! String
       
        students = DBManager.share.fetchUser()
      //  txtscore.text = "String(auser.game_score)"
        for auser in students{
            

            if auser.email == useremail && auser.game_score < score
            {
                
                auser.game_score = Int64(score)
                
                
                do{
                    
                  try DBManager.share.saveContext()
                    
                }
                
                catch{
                    
                    print("Error In updating")
                    
                }
                
             
                
            }
            
            
        }
    }
    
    
    
    
    
    func setupNewGameButton() {
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        let node = nodes(at: location)
        if node[0].name == "newGameButton" {
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        } else  if node[0].name == "menuButton" {
            
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

                        let vc = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController")

                        vc.view.frame = (self.view?.frame)!

                        vc.view.layoutIfNeeded()

                       

                        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:

                            {
                                self.view?.window?.rootViewController = vc

                        }, completion: { completed in

                

                        })

                       

                    }

           
        }
    }
    

