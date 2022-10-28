//
//  PokemonDetailsAboutView.swift
//  PokedexApp
//
//  Created by user224392 on 10/18/22.
//

import SwiftUI

struct PokemonDetailsAboutCell: View {
    @EnvironmentObject var pokemonStore: PokemonStore

    var pokemonDetails: PokemonDetails {
        return pokemonStore.pokemonDetails ?? PokemonDetails(baseExperience: 0, height: 0, name: "Default", stats: [], types: [], weight: 0)
    }

    var pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Grid(alignment: .topLeading) {
                    GridRow {
                        Text("Name")
                            .fontWeight(.bold)
                        Text(pokemon.name.capitalized)
                            .font(.custom("pixelmix", size: 14))
                    }
                    .padding(.bottom, 3.0)
                    GridRow {
                        Text("ID")
                            .fontWeight(.bold)
                        Text(String(format: "%03d", pokemon.id))
                            .font(.custom("pixelmix", size: 14))
                    }
                    .padding(.bottom, 3.0)
                    GridRow {
                        Text("Base")
                            .fontWeight(.bold)
                        Text(String("\(pokemonDetails.baseExperience) XP"))
                            .font(.custom("pixelmix", size: 14))
                    }
                    .padding(.bottom, 3.0)
                    GridRow {
                        Text("Weight")
                            .fontWeight(.bold)
                        Text(String("\(pokemonDetails.weight) kg"))
                            .font(.custom("pixelmix", size: 14))
                    }
                    .padding(.bottom, 3.0)
                    GridRow {
                        Text("Height")
                            .fontWeight(.bold)
                        Text(String("\(pokemonDetails.height) m"))
                            .font(.custom("pixelmix", size: 14))
                    }
                    .padding(.bottom, 3.0)
                    GridRow {
                        Text("Types")
                            .fontWeight(.bold)
                        HStack {
                            ForEach(pokemonDetails.types) { type in
                                Text(String(type.type.name))
                                    .font(.custom("pixelmix", size: 14))
                            }
                        }
                        
                    }
                    .padding(.bottom, 3.0)
                }
                Spacer()
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: 350
        )
    }
}

struct PokemonDetailsAboutCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsAboutCell(pokemon: Pokemon.testPokemon)
            .environmentObject(PokemonStore())
    }
}
