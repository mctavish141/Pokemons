//
//  PokemonDetailsViewModel.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import Foundation

protocol PokemonDetailsViewModelType {
    init(service: PokemonService, coordinatorDelegate: PokemonDetailsViewModelCoordinatorDelegate?, viewDelegate: PokemonDetailsViewModelViewDelegate?)
}

protocol PokemonDetailsViewModelCoordinatorDelegate: AnyObject {
    
}

protocol PokemonDetailsViewModelViewDelegate: AnyObject {
    
}
