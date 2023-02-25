//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

protocol PokemonListViewModelType {
    init(service: PokemonService, coordinatorDelegate: PokemonListViewModelCoordinatorDelegate?, viewDelegate: PokemonListViewModelViewDelegate?)
    
    func loadPokemons()
    func pokemonsCount() -> Int
    func pokemon(forItem item: Int) -> PokemonViewDataType?
    func pokemonImage(forItem item: Int, completion: @escaping (Data?) -> ())
}

protocol PokemonListViewModelCoordinatorDelegate: AnyObject {
    
}

protocol PokemonListViewModelViewDelegate: AnyObject {
    func update(withPokemons pokemons: [PokemonViewDataType])
    func update(withError error: String)
}

class PokemonListViewModel: PokemonListViewModelType {
    // MARK: - Model
    private var pokemons: [Pokemon]?
    
    // MARK: - Delegates
    private weak var coordinatorDelegate: PokemonListViewModelCoordinatorDelegate?
    private weak var viewDelegate: PokemonListViewModelViewDelegate?
    
    // MARK: - Service
    private let service: PokemonService
    
    // MARK: - Properties
    private typealias PokemonImage = Data
    private typealias PokemonImagesDictKey = String
    private var pokemonImagesDict: [PokemonImagesDictKey: PokemonImage] = [:]
    
    // MARK: - Protocol methods
    required init(service: PokemonService, coordinatorDelegate: PokemonListViewModelCoordinatorDelegate?, viewDelegate: PokemonListViewModelViewDelegate?) {
        
        self.service = service
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
    }
    
    func loadPokemons() {
        service.getPokemons { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonList):
                    self?.pokemons = pokemonList.results
                    self?.viewDelegate?.update(withPokemons: pokemonList.results.map { PokemonViewData(pokemon: $0) })
                case .failure(let error):
                    self?.viewDelegate?.update(withError: error.localizedDescription)
                }
            }
        }
    }
    
    func pokemonsCount() -> Int {
        return pokemons?.count ?? 0
    }
    
    func pokemon(forItem item: Int) -> PokemonViewDataType? {
        guard let pokemon = pokemons?[item] else { return nil }
        
        return PokemonViewData(pokemon: pokemon)
    }
    
    func pokemonImage(forItem item: Int, completion: @escaping (Data?) -> ()) {
        guard let pokemon = pokemons?[item] else {
            completion(nil)
            return
        }
        
        pokemonImage(forPokemon: pokemon, completion: completion)
    }
}

// MARK: - Loading pokemon details
extension PokemonListViewModel {
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
extension PokemonListViewModel {
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
