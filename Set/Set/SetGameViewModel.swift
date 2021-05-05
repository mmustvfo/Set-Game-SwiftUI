//
//  SetGameViewModel.swift
//  Set
//
//  Created by Mustafo on 03/05/21.
//

import Foundation

typealias Model = SetGameModel<SetShape, Shading, ShapeColor, NumberOfShapes>

class SetGameViewModel : ObservableObject {
    @Published private var setGameModel = Model()
    
    
    func choose(card: Model.Card) {
        setGameModel.choose(card: card)
    }
    
    var showedCards : [Model.Card] {
        setGameModel.displayedCards
    }
    
    var points : Int {
        setGameModel.points
    }
    func restart() {
        setGameModel = Model()
        setGameModel.points = 0
    }
    func addCards() {
        setGameModel.countOfDisplayedCards += 6
    }
    var numberOfCards : Int{
        setGameModel.countOfDisplayedCards
    }
}
