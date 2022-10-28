//
//  SplashScreenView.swift
//  PokedexApp
//
//  Created by user224392 on 10/19/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var imageSize = 0.9
    @State private var opacity = 0.5
    
    @StateObject var pokemonStore = PokemonStore()
    @StateObject var favouritesManager : FavouritesManager = .init()
    
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(pokemonStore)
                .environmentObject(favouritesManager)
        } else {
            VStack {
                VStack {
                    Spacer()
                    Image("pokeball.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.indigo)
                        .scaleEffect(imageSize)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.5).delay(1.5)) {
                                self.imageSize = 70
                            }
                        }.zIndex(1)
                    Text("Pokedex App")
                        .font(.custom("pixelmix", size: 28))
                        .foregroundColor(.black.opacity(0.8))
                    Spacer()
                    Text("Ruben Hoogeveen | 632079")
                        .font(.custom("pixelmix", size: 12))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.8)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
                    self.isActive = true
                }
                favouritesManager.loadFavouritePokemon()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
