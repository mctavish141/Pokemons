//
//  PokemonSpecies.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

struct PokemonSpecies: Decodable {
    let flavor_text_entries: [FlavorTextEntry]
}

struct FlavorTextEntry: Decodable {
    let flavor_text: String
}
