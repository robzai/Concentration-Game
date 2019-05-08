//
//  Card.swift
//  Concentration
//
//  Created by leo  luo on 2019-04-03.
//  Copyright © 2019 tk.onebite. All rights reserved.
//

import Foundation

//Card does not need an emoji, because it is UI independent.
//emoji is how you display the card, this is how the card
//behave, and how the game works
struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUnicIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init(){
        self.identifier = Card.getUnicIdentifier()
    }
    
}
