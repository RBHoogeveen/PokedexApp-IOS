//
//  FavouritesManager.swift
//  PokedexApp
//
//  Created by user224392 on 10/18/22.
//

import Foundation
import SwiftUI

class FavouritesManager: ObservableObject {
    @Published var favouritePokemon: [Pokemon] = []
    
    func toggleFavorite(_ pokemon: Pokemon) {
        if isFavorite(pokemon) {
            favouritePokemon = favouritePokemon.filter({ $0.id != pokemon.id })
        } else {
            favouritePokemon.append(pokemon)
        }
        saveFavouritePokemon()
    }
    
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        return favouritePokemon.contains(where: {$0.id == pokemon.id})
    }
    
    func saveFavouritePokemon() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(favouritePokemon)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "FavouritePokemon")

        } catch {
            print("Unable to Encode Array of Favourite Pokemon (\(error))")
        }
    }
    
    func loadFavouritePokemon() {
        if let data = UserDefaults.standard.data(forKey: "FavouritePokemon") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let favouritePokemon = try decoder.decode([Pokemon].self, from: data)
                
                self.favouritePokemon = favouritePokemon

            } catch {
                self.favouritePokemon = []
            }
        }
    }
}
