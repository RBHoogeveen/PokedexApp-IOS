//
//  AllPokemonsResponse.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import Foundation

struct AllPokemonsResponse: Decodable {
    let results: [PokemonEntity]
}

struct PokemonEntity: Decodable {
    let name: String
}
