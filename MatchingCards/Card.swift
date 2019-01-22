//
//  Card.swift
//  MatchingCards
//
//  Created by Artem Klimov on 20.01.2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int {return identifire}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifire == rhs.identifire
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifire: Int
    
    
    static var identifireFactory = 0
    
    static func getUniqueIdentifire() -> Int {
        identifireFactory += 1
        return identifireFactory
    }
    
    init() {
        self.identifire = Card.getUniqueIdentifire()
    }
}
