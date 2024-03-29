//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by Jonathan Kopp on 9/29/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //Initialize score starting at 0
    let ballonTexture = SKTexture(imageNamed: "ballonasset-1.png")
    var score = 0
    
    //Set up properties of the scoreLabel
    var scoreLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.text = "Score:"
        label.color = .white
        label.fontSize = 50
        
        return label
    }()
    
    override func didMove(to view: SKView) {
        //Called when the scene has been displayed
        
        //TODO: Create three squares with the names one,two,three
        
        
        let one = createSquares(name: "square1")
        let two = createSquares(name: "square2")
        let three = createSquares(name: "square3")
        
        
        
        
        
     
        //Setup the scoreLabel
        labelSetUp()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func labelSetUp() {
        scoreLabel.position.x = view!.bounds.width / 2
        scoreLabel.position.y = view!.bounds.height - 80
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
    }
    
    func randomNumber()-> CGFloat {
        //Width of the SKScene's view
        let viewsWidth = self.view!.bounds.width
        //Creates a random number from 0 to the viewsWidth
        let randomNumber = CGFloat.random(in: 0 ... viewsWidth)
        
        return randomNumber
    }
    
    func createSquares(name: String) {
        //TODO: Set up square properties
        //1. Create a CGSize for the square with (width: 80, height: 80)
        let size = CGSize(width: 80, height: 80)
        //2. Create a Square node with a texture of nil. a color of .green and the size we created above
        let square = SKSpriteNode(texture: self.ballonTexture, size: size)
       
        
        
        //3. Set the squares name to the name we pass into this function
        square.name = "name"
        
        //TODO: Set up the Squares x and y positions
        //1. Squares y positions shoud start at 40
        //2. Squares x positon should use the randomNumber generator provided above
        square.position.x = randomNumber()
        square.position.y = 40
        
        
        
        
        //Create an action to move the square up the screen
        let action = SKAction.customAction(withDuration: 2.0, actionBlock: { (square, _) in
            //TODO: Set up the squares animation
            SKAction.move(to: CGPoint(x: square.position.x, y: square.position.y), duration: 1.5)
            //1. The squares y position should increase by 10
            square.position.y += 5
            //2. Create an if statement that checks if the squares y position is >= to the screens height
            
            if square.position.y >= self.view!.bounds.height {
                self.score -= 1
                self.scoreLabel.text = "Score \(self.score)"
                square.position.y = 0
            }
            //If it is remove the square and create a new square with the same name
            
            if self.score < 0 {
                square.removeFromParent()
                self.scoreLabel.text = "GAME OVER"
            }
            
        })
        
        //TODO: Have the square run the above animation forever and add the square to the SKScene!
        square.run(SKAction.repeatForever(action))
        addChild(square)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Loop through an array of touch values
        for touch in touches {
            
            //Grab the position of that touch value
            let positionInScene = touch.location(in: self)
            
            //Find the name for the node in that location
            let name = self.atPoint(positionInScene).name
            
            //Check if there is an node there.
            if name != nil {
                //TODO: Remove the square
                let node = self.atPoint(positionInScene)
                node.removeFromParent()
                //Remove node from parent view
                //Increase the score by one
                score += 1
                scoreLabel.text = "Score: \(score)"
                //Create the square again with the same name
                _ = createSquares(name: name!)
            }
        }
    }
    
}
