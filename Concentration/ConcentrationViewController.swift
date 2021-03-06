//
//  ViewController.swift
//  Concentration
//
//  Created by leo  luo on 2019-04-03.
//  Copyright © 2019 tk.onebite. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    //this is a model, will be used by controller when controller needs
    //to talk to model.
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get{
            return (cardButtons.count + 1) / 2
        }
    }
    
    //Swift require all instant variables/properties be initialized
    //flipCount has been moved to Concentration(the model)
//    private(set) var flipCount = 0 {
//        //property observer, everytime this var changes, it's going to
//        //exectue the didSet
//        didSet{
//            flipCountLabel.text = "Flips: \(flipCount)"
//        }
//    }
    
//    private var emojiChoices = ["🎃","👻","👽","😈","👾","🌈","🤪","👿"]
//    private var emojiThemeChoices: Dictionary<String,[String]> = [
//        "animals": ["🐶","🐱","🐴","🦊","🐺","🐼","🐨","🐯","🦁"],
//        "faces":   ["😆","🙃","😶","😅","🙄","😑","🤣","😷","😂"],
//        "foods":   ["🌭","🥨","🥖","🍞","🥓","🥞","🥐","🥯","🍔"]
//    ]
//    lazy var emojiChoices = emojiThemeChoices.randomElement()?.value ?? []
    
    //each time a theme is set, reset emojiChoices and emoji
    var theme: [String]? = [] {
        didSet {
            emojiChoices = theme ?? []
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = ["😆","🙃","😶","😅","🙄","😑","🤣","😷","😂"]
    private var emoji = Dictionary<Card,String>()
    
    //a controller talk to a view through outlet, so when sth is updated
    //in a controller, we can change the view responsibly
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLable()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    //this is a outlet collection
    @IBOutlet private var cardButtons: [UIButton]!
    
    //a view talks to a controller through 'action'
    @IBAction private func tuchCard(_ sender: UIButton) {
        //flipCount has been moved to Concentration(the model)
        //flipCount = flipCount + 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            
            //controller tells model which card is chosen
            game.chooseCard(at: cardNumber)
            
            //redarw/update all cards/buttons in the view each time a card is tuched
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    @IBAction func tuchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
//        flipCount = 0
//        emojiChoices = emojiThemeChoices.randomElement()?.value ?? []
        updateViewFromModel()
    }
    
    private func updateFlipCountLable() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        //this if statement protect your code that can be called when your MVC is being prepared
        if cardButtons != nil {
            for index in 0..<cardButtons.count {
                let button = cardButtons[index]
                let card = game.cards[index]
                
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
                
                scoreLabel.text = "Score: \(game.score)"
                //            flipCountLabel.text = "Flips: \(game.flipCount)"
                updateFlipCountLable()
            }
        }
    }

    private func emoji(for card: Card) -> String {
        //if this emoji for that card is currently nil, then put an emoji
        //in the dictionary for that card
        if emoji[card] == nil {
            if emojiChoices.count > 0{
                //use remove to prevent duplicate emoji in dictionary
                emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        }
        
        //another way to deal with optional
        //if emoji[card.identifier] != nil {
        //    return emoji[card.identifier]!
        //} else {
        //    return "?"
        //}
        return emoji[card] ?? "?"
    }
    
//    func flipCard(withEmoji emoji: String, on button: UIButton) {
//        //if the button is showing an emoji(on the front side), set its
//        //background color to orange and hide the title(flip to the back);
//        //else set background color to white and show the emoji(flip to the front)
//        //'\(sth)' means it will interpret sth as string an then embed it in string
//        print("flipCard with \(emoji)")
//        if button.currentTitle == emoji{
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        } else {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else  {
            return 0
        }
    }
}
