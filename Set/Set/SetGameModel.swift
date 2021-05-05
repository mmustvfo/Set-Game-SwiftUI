//
//  SetGameModel.swift
//  Set
//
//  Created by Mustafo on 03/05/21.
//

import Foundation

struct SetGameModel<Shape : Hashable & CaseIterable,Shading : Hashable & CaseIterable,Color : Hashable & CaseIterable,Number : Hashable & CaseIterable>  {
    var cards : [Card]
    var countOfDisplayedCards = 12
    var points = 0
    
    init() {
        cards = SetGameModel<Shape, Shading, Color, Number>.newCards()
    }
    
    var displayedCards : [Card] {
        Array(cards.compactMap{ $0.isMatched ? nil : $0}.prefix(countOfDisplayedCards))
    }
    
    
    var choosenCards : [Card] {
        cards.compactMap { $0.isChoosen ? $0 : nil}
    }
    
    mutating func choose(card: Card){
        guard let index = cards.firstIndex(of: card) else {return}
        if choosenCards.count != 3 {cards[index].isChoosen.toggle()}
        if choosenCards.count == 3 {
            check()
        }
    }
    
    private mutating func check() {
        if let indexOfFirstMatchedCard = cards.firstIndex(of: choosenCards[0]) {
            if let indexOfSecondChoosenCard = cards.firstIndex(of: choosenCards[1]){
                if let indexOfThirdChoosenCard = cards.firstIndex(of: choosenCards[2]){
                    if cards[indexOfFirstMatchedCard].findOnlyOneMatch(firstCard: cards[indexOfSecondChoosenCard], secondCard: cards[indexOfThirdChoosenCard]) {
                        cards[indexOfFirstMatchedCard].isMatched = true
                        cards[indexOfSecondChoosenCard].isMatched = true
                        cards[indexOfThirdChoosenCard].isMatched = true
                        points += 1
                    } else {
                        cards[indexOfFirstMatchedCard].isChoosen = false
                        cards[indexOfSecondChoosenCard].isChoosen = false
                        cards[indexOfThirdChoosenCard].isChoosen = false
                
                        points -= 1
                    }
                }
            }
        }
    }
    
    static func newCards() -> [Card]{
        var array = [Card]()
        for numberOfShapes in Number.allCases {
            for shape in Shape.allCases {
                for shading in Shading.allCases {
                    for color in Color.allCases {
                        array.append(Card(numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        array.shuffle()
        return array
        
    }
    
    struct Card : Identifiable {
        var id = UUID()
        var numberOfShapes : Number
        var shape : Shape
        var shading : Shading
        let color : Color
        
        var isChoosen = false
        var isMatched = false
        
        func findOnlyOneMatch(firstCard: Card,secondCard: Card) -> Bool {
            if (numberOfShapes == firstCard.numberOfShapes ? numberOfShapes : nil) == secondCard.numberOfShapes ||
                numberOfShapes != firstCard.numberOfShapes && numberOfShapes != secondCard.numberOfShapes && firstCard.numberOfShapes != secondCard.numberOfShapes{}
            else {return false}
            
            if (shape == firstCard.shape ? shape : nil) == secondCard.shape ||
                shape != firstCard.shape && shape != secondCard.shape && firstCard.shape != secondCard.shape{}
            else {return false}
            
            if (shading == firstCard.shading ? shading : nil) == secondCard.shading ||
                shading != firstCard.shading && shading != secondCard.shading && firstCard.shading != secondCard.shading{}
            else{return false}
            
            if (color == firstCard.color ? color : nil) == secondCard.color ||
                color != firstCard.color && color != secondCard.color && firstCard.color != secondCard.color{}
            else {return false}
            
    
            return true
        }

    }
}


