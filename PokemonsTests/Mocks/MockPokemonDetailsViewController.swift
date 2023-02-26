//
//  MockPokemonDetailsViewController.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

@testable import Pokemons

class MockPokemonDetailsViewController: PokemonDetailsViewModelViewDelegate {
    var pokemonInfo: PokemonInfoViewDataType?
    var error: String?
    
    var dataUpdatedCallback: ((MockPokemonDetailsViewController) -> ())?
    
    func update(withPokemonInfo pokemonInfo: PokemonInfoViewDataType) {
        self.pokemonInfo = pokemonInfo
        self.dataUpdatedCallback?(self)
    }
    
    func update(withError error: String) {
        self.error = error
        self.dataUpdatedCallback?(self)
    }
}
