//
//  PokemonDetailsStatsView.swift
//  PokedexApp
//
//  Created by user224392 on 10/18/22.
//

import SwiftUI

struct PokemonDetailsStatsView: View {
    
    let stats: [PokemonStat]
    
    var body: some View {
        ScrollView {
            ForEach(stats) { stat in
                PokemonDetailsStatCell(stat: stat, percent: CGFloat(stat.baseStat))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct PokemonDetailsStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsStatsView(stats: PokemonDetails.testPokemonDetails.stats)
    }
}
