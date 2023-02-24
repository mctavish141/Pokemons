//
//  PokemonViewData.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

protocol PokemonViewDataType {
    var name: String { get }
}

struct PokemonViewData: PokemonViewDataType {
    private let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var name: String { return pokemon.name }
}
