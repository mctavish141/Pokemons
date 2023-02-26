//
//  PokemonInfoFetcher.swift
//  Pokemons
//
//  Created by Serhii Kopach on 26.02.2023.
//

protocol PokemonInfoFetcherType {
    func fetchPokemonInfo(forPokemon pokemon: Pokemon, completion: @escaping (Result<PokemonInfo, Error>) -> ())
}

class PokemonInfoFetcher {
    // MARK: - Service
    private let service: PokemonService
    
    init(service: PokemonService) {
        self.service = service
    }
}

extension PokemonInfoFetcher: PokemonInfoFetcherType {
    func fetchPokemonInfo(forPokemon pokemon: Pokemon, completion: @escaping (Result<PokemonInfo, Error>) -> ()) {
        
        pokemonSpecies(forPokemon: pokemon, completion: completion)
    }
}

// MARK: - Loading pokemon details
extension PokemonInfoFetcher {
    private func pokemonDetails(forPokemon pokemon: Pokemon, completion: @escaping (Result<PokemonDetails, Error>) -> ()) {
        
        service.getPokemonDetails(url: pokemon.url, completion: completion)
    }
}

// MARK: - Loading pokemon species
extension PokemonInfoFetcher {
    private func pokemonSpecies(forPokemon pokemon: Pokemon, completion: @escaping (Result<PokemonInfo, Error>) -> ()) {
        
        pokemonDetails(forPokemon: pokemon) { result in
            switch result {
            case .success(let details):
                self.pokemonSpecies(forPokemonDetails: details) { result in
                    switch result {
                    case .success(let species):
                        completion(.success(PokemonInfo(details: details, species: species)))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func pokemonSpecies(forPokemonDetails pokemonDetails: PokemonDetails, completion: @escaping (Result<PokemonSpecies, Error>) -> ()) {
        
        service.getPokemonSpecies(id: pokemonDetails.id, completion: completion)
    }
}
