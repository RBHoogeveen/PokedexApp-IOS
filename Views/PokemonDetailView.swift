//
//  DetailPageView.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import SwiftUI

struct PokemonDetailView: View {
    enum DetailSegments: String, CaseIterable {
        case about = "About"
        case stats = "Stats"
    }
    
    @EnvironmentObject var pokemonStore: PokemonStore
    @EnvironmentObject var favouritesManager: FavouritesManager
    
    var pokemonDetails: PokemonDetails {
        return pokemonStore.pokemonDetails ?? PokemonDetails(baseExperience: 0, height: 0, name: "Default", stats: [], types: [], weight: 0)
    }
    
    var pokemon: Pokemon
    
    @State private var isLoading = true
    @State private var didAppear = false
    @State private var selectedSegment: DetailSegments = .about
    @State private var isShareSheetShowing: Bool = false
    
    var body: some View {
        VStack{
            if(isLoading){
                ProgressView()
            } else {
                VStack() {
                    ZStack {
                        BackgroundCell(colors: pokemonDetails.typeColors).opacity(0.6)
                        VStack {
                            PokemonDetailsHeaderCell(name: pokemonDetails.name, pokemon: pokemon, types: pokemonDetails.types)
                                .zIndex(999)
                            ZStack {
                                Rectangle()
                                    .cornerRadius(30)
                                    .foregroundColor(Color(.systemBackground))
                                    .edgesIgnoringSafeArea(.all)
                                VStack {
                                    Picker("DetailSegments", selection: $selectedSegment) {
                                        ForEach(DetailSegments.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding(.top, 100)
                                    .padding()
                                    switch selectedSegment {
                                    case .about:
                                        PokemonDetailsAboutCell(pokemon: pokemon)
                                    case .stats:
                                        PokemonDetailsStatsView(stats: pokemonDetails.stats)
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .toolbar() {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        HStack {
                            Button(action: shareButton) {
                                Image(systemName: "square.and.arrow.up")
                            }
                            Button(
                                action: {
                                    favouritesManager.toggleFavorite(pokemon)
                                },
                                label: {
                                    let isFavorite = favouritesManager.isFavorite(pokemon)
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .foregroundColor(Color.pink)
                                }
                            )
                        }
                        
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear(perform: handleOnAppear)
    }
}

//MARK: Action handlers
private extension PokemonDetailView {
    
    func handleOnAppear() {
        pokemonStore.loadDetails(id: pokemon.id)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.isLoading = false
        }
    }
    
    func shareButton() {
        isShareSheetShowing.toggle()
        
        let url = self.pokemon.imageUrl
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.testPokemon)
            .environmentObject(PokemonStore())
            .environmentObject(FavouritesManager())
    }
}

