//
//  PokemonCell.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import SwiftUI

struct PokemonCell: View {
    
    @State private var isShareSheetShowing: Bool = false
    let pokemon: Pokemon
    @EnvironmentObject var favouritesManager: FavouritesManager
    
    var body: some View {
        let isFavorite: Bool = favouritesManager.isFavorite(pokemon)
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)){
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    HStack {
                        Text(String(format: "%03d", pokemon.id))
                            .font(.custom("pixelmix", size: 12))
                            .padding(.horizontal, 6.0)
                            .padding(.vertical, 4.0)
                            .foregroundColor(.white)
                            .background(Color.indigo.cornerRadius(5))
                        Spacer()
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(Color.pink)
                    }
                    AsyncImage(
                        url: pokemon.imageUrl,
                        content: { image in
                            image
                                .interpolation(.none)
                                .resizable()
                                .scaledToFill()
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .frame(width: 150, height: 125)
                }.padding(10)
                .background(.indigo.opacity(0.2))
                HStack(alignment: .center) {
                    Text(pokemon.name.capitalized)
                        .font(.custom("pixelmix", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 150, height: 30, alignment: .leading)
                .padding(10)
            }
            .contextMenu {
                Button(
                    action: {
                        favouritesManager.toggleFavorite(pokemon)
                    },
                    label: {
                        Label("Like \(pokemon.name)" , systemImage: isFavorite ? "heart.fill" : "heart")
                    }
                )
                Button(action: shareButton) {
                    Label("Share \(pokemon.name)", systemImage: "square.and.arrow.up")
                }
            }
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 1.5)
        }
    }
}

private extension PokemonCell {
    func shareButton() {
        isShareSheetShowing.toggle()
        
        let url = self.pokemon.imageUrl
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: Pokemon(id: 3, name: "Bulb"))
    }
}
