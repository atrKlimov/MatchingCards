//
//  MatchingCards.swift
//  MatchingCards
//
//  Created by Artem Klimov on 20.01.2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Foundation

class MatchingCards {
    
    var cards = [Card]()
    
    var flips = 0
    
    var score = 0
    
    struct Points {
        static let matchPoints = 2
        static let missMatchPoints = 1
    }
    
    
    var openedCards = [Int]()
    
    var indexOfFaceUpCard: Int? {
        get {
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func choosenCard(at index: Int) {
        if !cards[index].isMatched {
            flips += 1
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Points.matchPoints
                } else {
                    if openedCards.contains(index) {
                        score -= Points.missMatchPoints
                    }
                    if openedCards.contains(matchIndex) {
                        score -= Points.missMatchPoints
                    }
                    openedCards.append(index)
                    openedCards.append(matchIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfFaceUpCard = index
            }
        }
    }
    
    func resetProgress() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
        openedCards = []
        score = 0
        flips = 0
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}
