//
//  ViewController.swift
//  MatchingCards
//
//  Created by Artem Klimov on 20.01.2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = MatchingCards(numberOfPairsOfCards: numberOfPairsOfCards)
   
    var numberOfPairsOfCards: Int {
        return  (visibleCards.count + 1) / 2
    }
    

    
    var emoji = [Card:String]()
    
    var emojiChoices = ["🎃", "🦇", "🧛‍♂️", "🧙‍♀️", "🍭", "🍬", "😈", "👻", "😱", "🤡", "🙀", "🧞‍♀️", "🦉"]

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {

        game.resetProgress()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        for button in visibleCards {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        if let cardNumber = visibleCards.index(of: sender) {
            game.choosenCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    private var visibleCards: [UIButton]! {
        return cardButtons?.filter({!$0.superview!.isHidden})
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in visibleCards.indices {
            let button = visibleCards[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.isEnabled = true
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched {
                    button.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                    button.isEnabled = false
                } else {
                    button.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    button.isEnabled = true
                }
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flips)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card] ?? "?"
    }
}


