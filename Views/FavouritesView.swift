//
//  FavouritesView.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var favouritesManager: FavouritesManager
    @State private var searchText: String = ""
    
    var filteredFavouritePokemon: [Pokemon] {
        return searchText == "" ? favouritesManager.favouritePokemon : favouritesManager.favouritePokemon.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView() {
            VStack {
                ScrollView {
                    if (filteredFavouritePokemon != []) {
                        LazyVGrid(columns: columns) {
                            
                            ForEach(filteredFavouritePokemon, id: \.id) { pokemon in
                                PokemonCell(pokemon: pokemon)
                            }
                        }
                        .padding(.horizontal, 10.0)
                        .animation(.easeIn(duration: 0.3), value: filteredFavouritePokemon.count)
                    } else {
                        VStack {
                            Text("No favourite Pokemon found")
                                .font(.custom("pixelmix", size: 16))
                                .fontWeight(.semibold)
                        }
                    }
                }
                .searchable(text: $searchText)
            }
            .navigationTitle("Favourites")
        }
        .navigationViewStyle(.stack)
    }
}


struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
