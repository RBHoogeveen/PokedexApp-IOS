//
//  Pokemon.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import Foundation
import SwiftUI

struct Pokemon: Codable, Identifiable, Equatable {
    
    let id: Int
    let name: String
    
    var imageUrl: URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
    
    static let testPokemon = Pokemon(id: 1, name: "bulbasaur")
    
    static let pokemonTestList = [
    Pokemon(id: 1, name: "bulbasaur"),
    Pokemon(id: 4, name: "charmander"),
    Pokemon(id: 7, name: "squirtle"),
    Pokemon(id: 203, name: "ditto"),
    Pokemon(id: 132, name: "mewtwo")]
}

struct PokemonDetails: Codable {
    let baseExperience: Int
    let height: Int
    let name: String
    let stats: [PokemonStat]
    let types: [PokemonType]
    let weight: Int
    
    var typeColors: [Color] {
        var colors: [Color] = []
        types.forEach{ type in
            colors.append(
                backgroundColor(forType: type.type.name))
        }
        return colors
    }
    
    static let testPokemonDetails = PokemonDetails(baseExperience: 50, height: 20, name: "Test", stats: [PokemonStat(baseStat: 60, stat: PokemonStatName(name: "hp")), PokemonStat(baseStat: 50, stat: PokemonStatName(name: "attack"))], types: [PokemonType(type: PokemonTypeName(name: "poison")), PokemonType(type: PokemonTypeName(name: "grass"))], weight: 20)
}

private func backgroundColor(forType type: String) -> Color {
    switch type {
    case "fire": return Color(red: 238 / 255, green: 129 / 255, blue: 48 / 255)
    case "poison": return Color(red: 163 / 255, green: 62 / 255, blue: 161 / 255)
    case "grass": return Color(red: 122 / 255, green: 199 / 255, blue: 76 / 255)
    case "water": return Color(red: 99 / 255, green: 144 / 255, blue: 240 / 255)
    case "electric": return Color(red: 247 / 255, green: 208 / 255, blue: 44 / 255)
    case "psychic": return Color(red: 249 / 255, green: 85 / 255, blue: 135 / 255)
    case "normal": return Color(red: 168 / 255, green: 167 / 255, blue: 122 / 255)
    case "ground": return Color(red: 226 / 255, green: 191 / 255, blue: 101 / 255)
    case "fairy": return Color(red: 214 / 255, green: 133 / 255, blue: 173 / 255)
    case "dragon": return Color(red: 111 / 255, green: 53 / 255, blue: 252 / 255)
    case "ice": return Color(red: 150 / 255, green: 217 / 255, blue: 214 / 255)
    case "dark": return Color(red: 112 / 255, green: 87 / 255, blue: 70 / 255)
    case "steel": return Color(red: 183 / 255, green: 183 / 255, blue: 206 / 255)
    case "bug": return Color(red: 166 / 255, green: 185 / 255, blue: 26 / 255)
    case "rock": return Color(red: 182 / 255, green: 161 / 255, blue: 54 / 255)
    case "ghost": return Color(red: 115 / 255, green: 87 / 255, blue: 151 / 255)
    case "flying": return Color(red: 169 / 255, green: 143 / 255, blue: 243 / 255)
    case "fighting": return Color(red: 194 / 255, green: 46 / 255, blue: 40 / 255)
    default: return .indigo
    }
}
