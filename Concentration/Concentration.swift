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
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard :  Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    var points = 0
    var flipCounts = 0
    
    func chooseCard(at index : Int){
        if !cards[index].isMatched{
            flipCounts += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    points += 2
                } else{
                    points = cards[index].isAlreadySeen ? points - 1 : points
                    points = cards[matchIndex].isAlreadySeen ? points - 1 : points
                }
                cards[index].isFaceUp = true
                //indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isAlreadySeen = true
                cards[matchIndex].isAlreadySeen = true
            } else {
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
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
