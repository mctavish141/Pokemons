//
//  PokemonListViewModel.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

protocol PokemonListViewModelType {
    init(service: PokemonService, coordinatorDelegate: PokemonListViewModelCoordinatorDelegate?, viewDelegate: PokemonListViewModelViewDelegate?)
}

protocol PokemonListViewModelCoordinatorDelegate: AnyObject {
    
}

protocol PokemonListViewModelViewDelegate: AnyObject {
    
}

class PokemonListViewModel: PokemonListViewModelType {
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
}
