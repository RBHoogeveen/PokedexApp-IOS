//
//  PokemonAPI.swift
//  PokedexApp
//
//  Created by user224392 on 10/13/22.
//

import Foundation
import Combine

import Foundation
import Combine


class PokemonAPI {
    
    // MARK: Properties
    private var cancellables: [AnyCancellable] = []
    
    // MARK: Methods
    func fetchAllPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")!
        fetch(type: AllPokemonsResponse.self, url: url, completion: { result in
            switch result {
            case .success(let response):
                let pokemons = response.results
                    .enumerated()
                    .map({ (i, entity) in
                        return Pokemon(id: i + 1, name: entity.name)
                    })
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchDetails(id: Int, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        fetch(type: PokemonDetailsResponse.self, url: url, completion: { result in
            switch result {
            case .success(let response):
                let pokemonDetails = PokemonDetails(baseExperience: response.baseExperience, height: response.height, name: response.name, stats: response.stats, types: response.types, weight: response.weight)
                completion(.success(pokemonDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
}

// MARK: Helpers
private extension PokemonAPI {
    
    func fetch<T: Decodable>(type: T.Type, url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(error))
                    }
                },
                receiveValue: { response in
                    completion(.success(response))
                }
            )
            .store(in: &cancellables)
    }
}
