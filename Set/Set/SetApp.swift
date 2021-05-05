//
//  SetApp.swift
//  Set
//
//  Created by Mustafo on 03/05/21.
//

import SwiftUI

@main
struct SetApp: App {
    let gameViewModel = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(gameViewModel: gameViewModel)
        }
    }
}
