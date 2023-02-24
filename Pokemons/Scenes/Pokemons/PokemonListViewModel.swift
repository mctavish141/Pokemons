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
