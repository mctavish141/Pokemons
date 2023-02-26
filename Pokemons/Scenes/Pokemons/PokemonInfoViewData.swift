//
//  PokemonInfoViewData.swift
//  Pokemons
//
//  Created by Serhii Kopach on 26.02.2023.
//

protocol PokemonInfoViewDataType {
    var name: String { get }
    var height: String { get }
    var weight: String { get }
    var description: String { get }
}

struct PokemonInfoViewData: PokemonInfoViewDataType {
    private let pokemonInfo: PokemonInfo
    
    init(pokemonInfo: PokemonInfo) {
        self.pokemonInfo = pokemonInfo
    }
    
    var name: String { return pokemonInfo.details.name.capitalized }
    var height: String { return String(pokemonInfo.details.height) }
    var weight: String { return String(pokemonInfo.details.weight) }
    var description: String { return pokemonInfo.species.flavor_text_entries.first?.flavor_text ?? "" }
}
