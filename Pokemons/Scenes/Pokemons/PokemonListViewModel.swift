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
}
