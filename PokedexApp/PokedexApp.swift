//
//  PokedexAppApp.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    @StateObject var pokemonStore = PokemonStore()
    @StateObject var favouritesManager : FavouritesManager = .init()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
