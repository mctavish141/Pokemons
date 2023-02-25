//
//  PokemonImageService.swift
//  Pokemons
//
//  Created by Serhii Kopach on 25.02.2023.
//

import Foundation

protocol PokemonImageFetcherType {
    func fetchPokemonImage(forPokemon pokemon: Pokemon, completion: @escaping (Data?) -> ())
}

class PokemonImageFetcher {
    // MARK: - Service
    private let service: PokemonService
    
    // MARK: - Properties
    private typealias PokemonImage = Data
    private typealias PokemonImagesDictKey = String
    private var pokemonImagesDict: [PokemonImagesDictKey: PokemonImage] = [:]
    
    init(service: PokemonService) {
        self.service = service
    }
}

extension PokemonImageFetcher: PokemonImageFetcherType {
    func fetchPokemonImage(forPokemon pokemon: Pokemon, completion: @escaping (Data?) -> ()) {
        pokemonImage(forPokemon: pokemon, completion: completion)
    }
}

// MARK: - Loading pokemon details
extension PokemonImageFetcher {
    private func pokemonDetails(forPokemon pokemon: Pokemon, completion: @escaping (PokemonDetails?) -> ()) {
        service.getPokemonDetails(url: pokemon.url) { result in
            switch result {
            case .success(let resultPokemonDetails):
                completion(resultPokemonDetails)
            case .failure:
                completion(nil)
            }
        }
    }
}

// MARK: - Loading and caching pokemon image
extension PokemonImageFetcher {
    private func pokemonImage(forPokemon pokemon: Pokemon, completion: @escaping (PokemonImage?) -> ()) {
        // Image is already loaded
        if let pokemonImage = getPokemonImage(forKey: pokemon.name) {
            completion(pokemonImage)
            return
        }
        
        // Image is not loaded yet, load image
        pokemonDetails(forPokemon: pokemon) { [weak self] pokemonDetails in
            guard let self = self,
                  let pokemonDetails = pokemonDetails else {
                      completion(nil)
                      return
            }
            
            self.service.getPokemonImage(url: pokemonDetails.sprites.front_default) { [weak self] result in
                guard let self = self else {
                    completion(nil)
                    return
                }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let resultPokemonImage):
                        self.save(pokemonImage: resultPokemonImage, forKey: pokemon.name)
                        completion(resultPokemonImage)
                    case .failure:
                        completion(nil)
                    }
                }
            }
        }
    }
    
    private func getPokemonImage(forKey key: PokemonImagesDictKey) -> PokemonImage? {
        return pokemonImagesDict[key]
    }
    
    private func save(pokemonImage: PokemonImage, forKey key: PokemonImagesDictKey) {
        pokemonImagesDict[key] = pokemonImage
    }
}
