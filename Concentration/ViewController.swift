//
//  ViewController.swift
//  Concentration
//
//  Created by Nitai Halle on 19/04/2020.
//  Copyright © 2020 Nitai Halle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int{
        return (cardButtons.count + 1)/2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!{
        didSet{
            updateCardsFromModel()
        }
    }

    @IBOutlet weak var pointsLabel: UILabel!
    private lazy var currentTheme = themes.randomElement()!
    private let themes : [(name : String , emoji : [String] , backColorCard : UIColor, frontColorCard : UIColor)] =
        [("smileies",["😀","😃","😄","😁","😆","😅","😂","🤣","😜","🤪","💩","🤡"] ,#colorLiteral(red: 0, green: 1, blue: 0, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
         ("charcters",["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"],#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)),
         ("animals",["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮","🐷","🐸","🐵","🦍","🦏","🐪","🦒","🦘","🐃","🐂"    ,"🐄","🐎","🐖","🐏"] ,#colorLiteral(red: 1, green: 0.7159882188, blue: 0.6841184497, alpha: 1),#colorLiteral(red: 0.2969636321, green: 0.6666125059, blue: 1, alpha: 1)),
         ("food",["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅","🍆","🥑"] ,#colorLiteral(red: 0.9481509328, green: 0.986513555, blue: 0, alpha: 1),#colorLiteral(red: 0.9469011426, green: 0.1380769014, blue: 1, alpha: 1)),
         ("flags",["🇱🇷","🇮🇹","🇮🇱","🇮🇪","🇮🇳","🇬🇪","🇩🇪","🇬🇷","🇭🇺","🇫🇰","🇪🇺","🇪🇹","🇬🇶","🇪🇬","🇩🇴","🇩🇯","🇨🇦","🇨🇱","🇧🇷","🇧🇪"] ,#colorLiteral(red: 0, green: 1, blue: 0.7473010421, alpha: 1),#colorLiteral(red: 0.1322995424, green: 0.3210541904, blue: 1, alpha: 1)),
         ("hands",["🤙","👋","🖖","🖐️","🤚","👇","👉","👈","👌","🤘","✌️","🤞","🤜","🤛","✊","👊","👎","👍🏻","👏","🙌"] ,#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),]
    
    @IBOutlet private weak var flipsCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        updateCardsFromModel()
        flipsCountLabel.text = "Flips : \(game.flipCounts)"
        pointsLabel.text = "Points : \(game.points)"
    }
    
    private func updateCardsFromModel(){
        for idx in cardButtons.indices{
            let button = cardButtons[idx]
            let card = game.cards[idx]
            if card.isFaceUp{
                button.setTitle(emoji(for:card) , for:    UIControl.State.normal)
                button.backgroundColor = currentTheme.backColorCard
            } else {
                button.setTitle("", for:    UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : currentTheme.frontColorCard
            }
        }
    }
    
    private var emoji = [Card:String]()
    
    private lazy var emojiChoices = currentTheme.emoji
    
    private func emoji(for card : Card) -> String{
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count) //(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "king"
    }
    
    @IBAction private func newGame() {
        game.reset()
        emoji.removeAll()
        currentTheme = themes.randomElement()!
        emojiChoices = currentTheme.emoji
        updateViewFromModel()
    }
}

