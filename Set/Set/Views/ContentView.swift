//
//  ContentView.swift
//  Set
//
//  Created by Mustafo on 03/05/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameViewModel : SetGameViewModel
    @State private var gameEntered = false
    @State private var gameEnded = false
    var body: some View {
        VStack(spacing:3) {
            HStack(spacing:100){
                Button(action: {
                    withAnimation(.spring()){
                        gameViewModel.restart()
                    }
                }, label: {
                    Text("Restart")
                        .font(.title)
                })
                Button(action: {
                    withAnimation(.spring()){
                        gameViewModel.addCards()
                    }
                }, label: {
                    Text("Add Cards")
                        .font(.title)
                })
            }
            Grid(gameViewModel.showedCards) { card in
                CardView(card: card, numberOfCards: gameViewModel.numberOfCards)
                        .offset(gameEntered ? .zero : getSideScreen())
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn(duration:0.3)){
                                gameViewModel.choose(card: card)
                            }
                            gameEnded  = gameViewModel.showedCards.count == 0
                        }
                        .transition(AnyTransition.offset(getSideScreen()))
                }
            Text("Points: \(gameViewModel.points)")
                .font(.title)
        }
        .onAppear{
            withAnimation(Animation.spring()){
                gameEntered = true
            }
        }
        .alert(isPresented: $gameEnded, content: {
            Alert(title: Text("Game Over!"), message: Text("You got \(gameViewModel.points) points"), dismissButton: .default(Text("New Game"), action: {
                gameViewModel.restart()
            }))
        })
    }
    
    func getSideScreen() -> CGSize {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let randomHeight = CGFloat.random(in: (height - 20)...height + 50)
        let randomWidth = CGFloat.random(in: (width - 20)...width + 50)
        
        if randomHeight >= height {
            return CGSize(width: -randomWidth, height: randomHeight)
        } else {
            return CGSize(width: width, height: -height - 80)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gameViewModel: SetGameViewModel())
    }
}

