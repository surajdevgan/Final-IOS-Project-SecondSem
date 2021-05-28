//
//  MenuScene.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//

import SpriteKit

class MenuScene: SKScene {
    
    var starField : SKEmitterNode!
    
    var newGameButtonNode: SKSpriteNode!
    var difficultyButtonNode: SKSpriteNode!
    var difficultyLabelNode: SKLabelNode!
    var gameTitleLabelNode: SKLabelNode!
    
    let newGameButtonName = "newGameButton"
    let difficultyButtonName = "difficultyButton"
    
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        setupGameTitleLabel()
        setupStartField()
        setupNewGameButtonNode()
        setupDifficultyButtonNode()
        setupDifficultLabelNode()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        guard let location = touch?.location(in: self) else { return }
        let nodesArray = self.nodes(at: location)
        if nodesArray.first?.name == newGameButtonName {
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        } else if nodesArray.first?.name == difficultyButtonName {
            changeDifficulty()
        }
        
    }
    //gameTitleLabel
    private func setupGameTitleLabel() {
        gameTitleLabelNode = childNode(withName: "gameTitleLabel") as? SKLabelNode
        let yPosition = gameTitleLabelNode.position.y
        gameTitleLabelNode.position = CGPoint(x: frame.size.width/2, y: yPosition)
    }
    
    private func setupNewGameButtonNode() {
        newGameButtonNode = self.childNode(withName: newGameButtonName) as? SKSpriteNode
        let yPosition = newGameButtonNode.position.y
        newGameButtonNode.position = CGPoint(x: frame.size.width/2, y: yPosition)
    }
    
    private func setupStartField() {
        starField = self.childNode(withName: "starField") as? SKEmitterNode
        starField.advanceSimulationTime(10)
    }
    
    private func setupDifficultyButtonNode() {
        difficultyButtonNode = self.childNode(withName: difficultyButtonName) as? SKSpriteNode
        difficultyButtonNode.texture = SKTexture(imageNamed: difficultyButtonName)
        let yPosition = difficultyButtonNode.position.y
        difficultyButtonNode.position = CGPoint(x: frame.size.width/2, y: yPosition)
    }
    
    private func setupDifficultLabelNode() {
        difficultyLabelNode = self.childNode(withName: "difficultyLabel") as? SKLabelNode
        let yPosition = difficultyLabelNode.position.y
        difficultyLabelNode.position = CGPoint(x: frame.size.width/2, y: yPosition)
        if let gameDifficulty = userDefaults.value(forKey: Constants.UserDefaultKeys.GameDifficulty) as? String {
            difficultyLabelNode.text = gameDifficulty
        } else {
            difficultyLabelNode.text = DifficultyOptions.Easy.description
        }
    }
    
    func changeDifficulty() {
        guard let difficulty = DifficultyOptions(rawValue: difficultyLabelNode.text!) else { return }
        switch difficulty {
        case .Easy:
            difficultyLabelNode.text = DifficultyOptions.Medium.description
            userDefaults.set(DifficultyOptions.Medium.description, forKey: Constants.UserDefaultKeys.GameDifficulty)
        case .Medium:
            difficultyLabelNode.text = DifficultyOptions.Hard.description
            userDefaults.set(DifficultyOptions.Hard.description, forKey: Constants.UserDefaultKeys.GameDifficulty)
        case .Hard:
            difficultyLabelNode.text = DifficultyOptions.Easy.description
            userDefaults.set(DifficultyOptions.Easy.description, forKey: Constants.UserDefaultKeys.GameDifficulty)
        }
    }
    
    
}

