//
//  PokemonDetailsStatCell.swift
//  PokedexApp
//
//  Created by user224392 on 10/18/22.
//

import SwiftUI

struct PokemonDetailsStatCell: View {
    let stat: PokemonStat
    
    var width: CGFloat = 350
    var percent: CGFloat = 50
    
    var body: some View {
        let multiplier = width / 255
        VStack(alignment: .leading) {
            HStack{
                Text(stat.stat.name.uppercased())
                    .fontWeight(.semibold)
                    .font(.custom("pixelmix", size: 16))
                Spacer()
                Text(String(format: "%03d", stat.baseStat))
                    .font(.custom("pixelmix", size: 14))
            }
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: width, height: 5)
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.indigo)
                    .frame(width: percent * multiplier, height: 5)
            }.cornerRadius(45.0)
        }
        .padding(.bottom, 10)
        .frame(width: 350)
    }
}

struct PokemonDetailsStatCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsStatCell(stat: PokemonStat(baseStat: 40, stat: PokemonStatName(name: "HP")))
    }
}
