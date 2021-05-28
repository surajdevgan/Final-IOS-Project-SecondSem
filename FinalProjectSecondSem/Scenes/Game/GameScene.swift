//
//  GameScene.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//
import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, UIGestureRecognizerDelegate{
   // var villian = SKSpriteNode?
//  var Bullet = SKSpriteNode(imageNamed: "dragon_fire")
    var starField: SKEmitterNode!
    var player: SKSpriteNode!
    var villianTimer : Timer?
    var scoreLabel: SKLabelNode!
    var timer : Timer?
    let difficultManager = DifficultyManager()
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let torpedoSoundAction: SKAction = SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false)
    var gameTimer: Timer!
    var attackers = ["meteor","alien"]
    
    let alienCategory: UInt32 = 0x1 << 1
   
    let villianCategory: UInt32 = 0x1 << 1
    
    let villianBulletCategory: UInt32 = 0x1 << 0
    
    let torpedoCategory: UInt32 = 0x1 << 0
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    var livesArray: [SKSpriteNode]!
    
    let userDefaults = UserDefaults.standard
    
    
    
    override func didMove(to view: SKView) {
        
        // timer for villian movement
     
    villianTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
                 self.setupVillian()
             })
  
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(villianBullets), userInfo: nil, repeats: true)
     
  
        
        setupLives()
        setupStarField()
        setupPlayer()
        setupPhisicsWord()
        setupScoreLabel()
        setupAliensAndAsteroids()
        setupCoreMotion()
     
        
        
    }
    
    
    
    //creating the villian

func setupVillian(){
    let villian = SKSpriteNode(imageNamed: "dragon")
   
    villian.size = CGSize(width: 80, height: 80)
    let maxY = size.height - villian.size.height
    let minY = -size.height / 2 +  8 * villian.size.height
         let range = maxY - minY
        let villianY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
            
    villian.position = CGPoint(x: size.width + villian.size.height / 2, y: villianY)
            
    let moveLeft = SKAction.moveBy(x: -size.height - villian.size.width, y: 0, duration: 4)
 
        villian.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    
    villian.physicsBody = SKPhysicsBody(circleOfRadius: villian.size.width/2)
    
    villian.physicsBody?.categoryBitMask = alienCategory
    villian.physicsBody?.contactTestBitMask = torpedoCategory
    villian.physicsBody?.collisionBitMask = 0
 
   
    addChild(villian)
}



// creating bullets spawning from villian

@objc  func villianBullets(){
    
    
 let villian = SKSpriteNode(imageNamed: "dragon")
  
    let Bullet = SKSpriteNode(imageNamed: "dragon_fire")
Bullet.size = CGSize(width: 30, height: 30)
    Bullet.zPosition = -2
    Bullet.position = CGPoint(x: size.width + villian.position.x   , y: size.height / 2.5 + villian.position.y - Bullet.size.height)

let action = SKAction.moveTo(y: -self.size.width , duration: 4)
    let moveLeft = SKAction.moveBy(x: -size.height - villian.size.width, y: 0, duration: 4)
 
    Bullet.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    Bullet.run(SKAction.sequence([action, SKAction.removeFromParent()]))
    
    Bullet.physicsBody = SKPhysicsBody(circleOfRadius: Bullet.size.width/2)
    
    Bullet.physicsBody?.categoryBitMask = alienCategory
    Bullet.physicsBody?.contactTestBitMask = torpedoCategory
    Bullet.physicsBody?.collisionBitMask = 0

    self.addChild(Bullet)
    
}

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
            
        
            
        }
    }
    
    
   
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            player.position.x = location.x
            
        }
    }
    
    

    
    
    func setupLives() {
        livesArray = [SKSpriteNode]()
        for life in 1...5 {
            let lifeNode = SKSpriteNode(imageNamed: "heart")
            lifeNode.size = CGSize(width: 35, height: 35)
            lifeNode.zPosition = 5
            lifeNode.position = CGPoint(x: self.frame.size.width - 50 - CGFloat(4 - life) * lifeNode.size.width, y: frame.size.height - 50)
            self.addChild(lifeNode)
            livesArray.append(lifeNode)
        }
        
    }
    
    func setupCoreMotion() {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data: CMAccelerometerData?, error: Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
            
        }
    }
    
    
    func setupPhisicsWord() {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        backgroundColor = .black
    }
    
    func setupStarField() {
        starField = SKEmitterNode(fileNamed: "Starfield")
        
        starField.position = CGPoint(x: 0, y: self.frame.maxY)
        starField.advanceSimulationTime(10)
        addChild(starField)
        starField.zPosition = -1
    }
    
    func setupPlayer() {
        player = SKSpriteNode(imageNamed: "spaceship")
        player.size = CGSize(width: 50, height: 50)
        player.position = CGPoint(x: frame.size.width / 2, y: player.size.height / 2 + 20)
        addChild(player)
    }
    
    func setupScoreLabel() {
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: (scoreLabel.frame.width / 2) + 10, y: frame.size.height - 50)
        scoreLabel.zPosition = 5
        scoreLabel.fontSize = 25
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.color = .white
        addChild(scoreLabel)
    }
    
    func setupAliensAndAsteroids() {
        let timeInterval = difficultManager.getAlienAparitionInterval()
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(addAliensAndAsteroids), userInfo: nil, repeats: true)
    }
    
    @objc func addAliensAndAsteroids() {
        //Shuffled array of attackers
        attackers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: attackers) as! [String]
        let attaker = SKSpriteNode(imageNamed: attackers[0])
       
        let attakerPosition = GKRandomDistribution(lowestValue: 0, highestValue: Int(frame.size.width))
        let position = CGFloat(attakerPosition.nextInt())
        attaker.size = CGSize(width: 50, height: 50)
        attaker.position = CGPoint(x: position, y: frame.size.height + attaker.size.height)
        attaker.physicsBody = SKPhysicsBody(circleOfRadius: attaker.size.width/2)
        
        attaker.physicsBody?.categoryBitMask = alienCategory
        attaker.physicsBody?.contactTestBitMask = torpedoCategory
        attaker.physicsBody?.collisionBitMask = 0
        
        addChild(attaker)
        
        let animationDuration = difficultManager.getAlienAnimationDutationInterval()
        
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -attaker.size.height), duration: animationDuration))
        actionArray.append(SKAction.run(alienGotBase))
        actionArray.append(SKAction.removeFromParent())
        
        attaker.run(SKAction.sequence(actionArray))
    }
    
    func alienGotBase() {
        run(SKAction.playSoundFileNamed("looseLife.mp3", waitForCompletion: false))
        if livesArray.count > 0 {
            let lifeNode = livesArray.first
            lifeNode?.removeFromParent()
            livesArray.removeFirst()
        }
        if livesArray.count == 0 {
            let transition = SKTransition.flipVertical(withDuration: 0.5)
            let gameScene = SKScene(fileNamed: "GameOver") as! GameOver
            gameScene.score = self.score
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpedo()
       
    }
    
    func fireTorpedo() {
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = player.position
        torpedoNode.position.y += 5
        torpedoNode.size = CGSize(width: 30, height: 30)
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width/2)
        
        torpedoNode.physicsBody?.categoryBitMask = torpedoCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.contactTestBitMask = villianBulletCategory
        torpedoNode.physicsBody?.contactTestBitMask = villianCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(torpedoNode)
        
        let animationDuration = 1.0
        
        var actionArray = [SKAction]()
        actionArray.append(torpedoSoundAction)
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: frame.size.height + torpedoNode.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        torpedoNode.run(SKAction.sequence(actionArray))
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyWithMaxCategoryBitMask: SKPhysicsBody
        var bodyWithMinCategoryBitMask: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            bodyWithMaxCategoryBitMask = contact.bodyA
            bodyWithMinCategoryBitMask = contact.bodyB
        } else {
            bodyWithMaxCategoryBitMask =  contact.bodyB
            bodyWithMinCategoryBitMask = contact.bodyA
        }
        let isTorpedoBody = (bodyWithMaxCategoryBitMask.categoryBitMask & torpedoCategory) != 0
        let isAlienBody = (bodyWithMinCategoryBitMask.categoryBitMask & alienCategory) != 0
        
        if  isTorpedoBody && isAlienBody {
            torpedoDidCollideWithAlien(torpedoNode: bodyWithMaxCategoryBitMask.node as! SKSpriteNode, alienNode: bodyWithMinCategoryBitMask.node as! SKSpriteNode)
        }
    }
    
    func torpedoDidCollideWithAlien(torpedoNode: SKSpriteNode, alienNode: SKSpriteNode) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
       
        addChild(explosion)
        
        run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
       
       run(SKAction.wait(forDuration: 1)) {
            explosion.removeFromParent()
        }
        score += 5
       
    }
    
    override func didSimulatePhysics() {
        player.position.x += xAcceleration * 50
        if player.position.x < -40 {
            player.position = CGPoint(x: CGFloat(frame.size.width), y: player.position.y)
        } else if player.position.x > frame.size.width  + 40 {
            player.position = CGPoint(x: -CGFloat(40), y: player.position.y)
        }
    }
}
