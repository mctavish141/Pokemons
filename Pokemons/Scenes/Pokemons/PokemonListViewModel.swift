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
    func itemSelected(_ item: Int)
}

protocol PokemonListViewModelCoordinatorDelegate: AnyObject {
    func pokemonSelected(_ pokemon: Pokemon, imageFetcher: PokemonImageFetcherType)
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
    private let imageFetcher: PokemonImageFetcherType
    
    // MARK: - Protocol methods
    required init(service: PokemonService, coordinatorDelegate: PokemonListViewModelCoordinatorDelegate?, viewDelegate: PokemonListViewModelViewDelegate?) {
        
        self.service = service
        self.imageFetcher = PokemonImageFetcher(service: service)
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
        
        imageFetcher.fetchPokemonImage(forPokemon: pokemon, completion: completion)
    }
    
    func itemSelected(_ item: Int) {
        guard let pokemon = pokemons?[item] else {
            return
        }
        
        coordinatorDelegate?.pokemonSelected(pokemon, imageFetcher: imageFetcher)
    }
}
