//
//  Concentration.swift
//  Concentration
//
//  Created by Nitai Halle on 19/04/2020.
//  Copyright © 2020 Nitai Halle. All rights reserved.
//

import Foundation
class Concentration
{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard :  Int? {
        get{
            let indexesCardsIsFaceUp = cards.indices.filter {cards[$0].isFaceUp}
            return indexesCardsIsFaceUp.count == 1 ? indexesCardsIsFaceUp.first : nil
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var points = 0
    private(set) var flipCounts = 0
    
    func chooseCard(at index : Int){
        if !cards[index].isMatched{
            if !cards[index].isFaceUp{
                flipCounts += 1
            }
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    points += 2
                } else{
                    points = cards[index].isAlreadySeen ? points - 1 : points
                    points = cards[matchIndex].isAlreadySeen ? points - 1 : points
                }
                cards[index].isFaceUp = true
                cards[index].isAlreadySeen = true
                cards[matchIndex].isAlreadySeen = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards += [card]

        }
        cards.shuffle()
    }
    
    func reset(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].isAlreadySeen = false
            points = 0
            flipCounts = 0
        }
        cards.shuffle()
    }
}
