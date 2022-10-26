//
//  PokemonGridView.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import SwiftUI

struct PokemonGridView: View {
    @EnvironmentObject var pokemonStore: PokemonStore
    @State private var searchText: String = ""
    
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonStore.pokemons : pokemonStore.pokemons.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView() {
            ScrollView {
               LazyVGrid(columns: columns) {
                   
                   ForEach(filteredPokemon, id: \.id) { pokemon in
                       PokemonCell(pokemon: pokemon)
                   }
               }
               .padding(.horizontal, 10.0)
               .animation(.easeIn(duration: 0.3), value: filteredPokemon.count)
           }
            .refreshable {
                handleOnAppear()
            }
           .searchable(text: $searchText)
           .onAppear(perform: handleOnAppear)
           .navigationTitle("Pokémon")
        }
        .navigationViewStyle(.stack)
    }
}

//MARK: Action handlers
private extension PokemonGridView {
    
    func handleOnAppear() {
        pokemonStore.loadData()
    }
}


struct PokemonGridView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGridView()
    }
}


