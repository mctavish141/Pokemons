//
//  MockPokemonListViewController.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

@testable import Pokemons

class MockPokemonListViewController: PokemonListViewModelViewDelegate {
    var pokemons: [PokemonViewDataType]?
    var error: String?
    
    var dataUpdatedCallback: ((MockPokemonListViewController) -> ())?
    
    func update(withPokemons pokemons: [PokemonViewDataType]) {
        self.pokemons = pokemons
        self.dataUpdatedCallback?(self)
    }
    
    func update(withError error: String) {
        self.error = error
        self.dataUpdatedCallback?(self)
    }
}
