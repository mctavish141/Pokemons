//
//  PokemonDetailsViewModel.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

protocol PokemonDetailsViewModelType {
    init(pokemon: Pokemon, service: PokemonService, imageFetcher: PokemonImageFetcherType, coordinatorDelegate: PokemonDetailsViewModelCoordinatorDelegate?, viewDelegate: PokemonDetailsViewModelViewDelegate?)
    
    func loadPokemonInfo()
    func pokemonImage(completion: @escaping (Data?) -> ())
}

protocol PokemonDetailsViewModelCoordinatorDelegate: AnyObject {
    
}

protocol PokemonDetailsViewModelViewDelegate: AnyObject {
    func update(withPokemonInfo pokemonInfo: PokemonInfoViewDataType)
    func update(withError error: String)
}

class PokemonDetailsViewModel: PokemonDetailsViewModelType {
    // MARK: - Model
    private var pokemon: Pokemon
    private var pokemonDetails: PokemonDetails?
    private var pokemonSpecies: PokemonSpecies?
    
    // MARK: - Delegates
    private weak var coordinatorDelegate: PokemonDetailsViewModelCoordinatorDelegate?
    private weak var viewDelegate: PokemonDetailsViewModelViewDelegate?
    
    // MARK: - Service
    private let service: PokemonService
    
    // MARK: - Properties
    private let imageFetcher: PokemonImageFetcherType
    private let infoFetcher: PokemonInfoFetcherType
    
    // MARK: - Protocol methods
    required init(pokemon: Pokemon, service: PokemonService, imageFetcher: PokemonImageFetcherType, coordinatorDelegate: PokemonDetailsViewModelCoordinatorDelegate?, viewDelegate: PokemonDetailsViewModelViewDelegate?) {
        
        self.pokemon = pokemon
        self.service = service
        self.imageFetcher = imageFetcher
        self.infoFetcher = PokemonInfoFetcher(service: service)
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
    }
    
    func loadPokemonInfo() {
        infoFetcher.fetchPokemonInfo(forPokemon: pokemon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemonInfo):
                    self?.viewDelegate?.update(withPokemonInfo: PokemonInfoViewData(pokemonInfo: pokemonInfo))
                    
                case .failure(let error):
                    self?.viewDelegate?.update(withError: error.localizedDescription)
                }
            }
        }
    }
    
    func pokemonImage(completion: @escaping (Data?) -> ()) {
        imageFetcher.fetchPokemonImage(forPokemon: pokemon, completion: completion)
    }
}
