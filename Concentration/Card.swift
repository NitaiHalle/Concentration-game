//
//  Card.swift
//  Concentration
//
//  Created by Nitai Halle on 19/04/2020.
//  Copyright © 2020 Nitai Halle. All rights reserved.
//

import Foundation
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    var isAlreadySeen = false
    private static var UniqueIdentifierFactory = 0
    private static func getUniqueIdentifier() -> Int
    {
        UniqueIdentifierFactory += 1
        return UniqueIdentifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
