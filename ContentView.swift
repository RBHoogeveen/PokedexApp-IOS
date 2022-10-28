//
//  ContentView.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import SwiftUI
import Combine

import SwiftUI

struct ContentView: View {
    @State var tabSelection: Tabs = .tab1
    var body: some View {
        TabView(selection: $tabSelection){
            PokemonGridView()
            .tabItem {
                VStack {
                    if (tabSelection == .tab1) {
                        Image("pokeball.fill")
                            .resizable()
                    } else {
                        Image("pokeball.line")
                            .resizable()
                    }
                    Text("Pokémon")
                }
            }
            .tag(Tabs.tab1)
            
            FavouritesView()
            .tabItem {
                if (tabSelection == .tab2) {
                    Image(systemName: "heart.fill")
                        .resizable()
                } else {
                    Image(systemName: "heart")
                        .resizable()
                }
                Text("Favourites")
            }
            .tag(Tabs.tab2)
        }
    }
    
    enum Tabs{
        case tab1, tab2
    }
    
    func returnNaviBarTitle(tabSelection: Tabs) -> String{
        switch tabSelection{
            case .tab1: return "Pokémon"
            case .tab2: return "Favourites"
        }
    }
}
