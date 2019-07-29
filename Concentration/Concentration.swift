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
struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceupCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        //if we found more than one face up card...should never goes here
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            //tuen all cards face down except the 'indexOfOneAndOnlyFaceupCard' one
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    //only functions we need to put mutating on while using struct. This is because struct is value type, and it gets copy whil passing around using copy on write semantic, so we care when it is mutating.
    mutating func chooseCard(at index: Int){
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        
        //when you assert something could be true, and if it's not the program crash and print out an error. Assertions crash your program while develement, but they are ignore when you ship to the App Store
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index) : chonsen index not in the cards")
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
//                indexOfOneAndOnlyFaceupCard = nil
            } else {
                //1. no card is face up when user choose a card, then flip it face up
                //2. 2 cards are face up eather matching or not matching, if that's true, when user choose another card, flip those cards face down, and the chosen on face up
                
                //these 4 lines of code below now is hadled by computed property
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceupCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0 , "Concentration.init(\(numberOfPairsOfCards)) : must have at least one pair of cards")
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
