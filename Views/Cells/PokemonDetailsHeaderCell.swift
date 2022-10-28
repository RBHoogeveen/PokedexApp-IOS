//
//  PokemonDetailsHeaderView.swift
//  PokedexApp
//
//  Created by user224392 on 10/18/22.
//

import SwiftUI

struct PokemonDetailsHeaderCell: View {
    
    @EnvironmentObject var pokemonStore: PokemonStore
    let name: String
    let pokemon: Pokemon
    let types: [PokemonType]
    
    @State private var didAppear = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name.capitalized)
                    .font(.custom("pixelmix", size: 24))
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Text(String(format: "#%03d", pokemon.id))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .font(.custom("pixelmix", size: 16))
            }
            HStack {
                ForEach(types) { type in
                    Text(type.type.name)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 5.0)
                        .padding(.horizontal, 10.0)
                        .foregroundColor(.white)
                        .background(pokemonStore.backgroundColor(forType: type.type.name).cornerRadius(40).shadow(radius: 1))
                }
            }
            AsyncImage(
                url: pokemon.imageUrl,
                content: { image in
                    image
                        .interpolation(.none)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    ProgressView()
                }
            )
            .shadow(radius: 5)
            .onAppear {
                didAppear = true
            }
            .scaleEffect(didAppear ? 0.7 : 2)
            .opacity(didAppear ? 1 : 0)
            .padding(.bottom, -100.0)
            .animation(.easeInOut .delay(0.2))
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 150
            )
        }
        .padding(.horizontal, 20.0)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: 200,
              alignment: .topLeading
            )
    }
}

struct PokemonDetailsHeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsHeaderCell(name: "Default", pokemon: Pokemon.testPokemon, types: [])
            .environmentObject(PokemonStore())
    }
}
