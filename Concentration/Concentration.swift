//
//  Concentration.swift
//  Concentration
//
//  Created by leo  luo on 2019-04-03.
//  Copyright © 2019 tk.onebite. All rights reserved.
//

import Foundation

//Class get a free init() with no arguments as long as all their
//vars are initialized.
class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceupCard: Int?
    
    func chooseCard(at index: Int){
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        
        //ignore card that is already been matched
        if !cards[index].isMatched {
            //there is one card face up, and now need to match
            if let matchIndex = indexOfOneAndOnlyFaceupCard, matchIndex != index {
                //check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceupCard = nil
            } else {
                //1. no card is face up when user choose a card, then flip it face up
                //2. 2 cards are face up eather matching or not matching, if that's true, when user choose another card, flip those cards face down, and the chosen on face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceupCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        //'_' in Swift means ignore this, I am not going to use this
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            //equal to 'let matchingCard = Card(identifier: identifier)'
            //because struc gets copy while passing
            let matchingCard = card
            
            cards.append(card)
            cards.append(matchingCard)
            
            //TODO: Shuffle the cards
            
        }
    }
    
}
