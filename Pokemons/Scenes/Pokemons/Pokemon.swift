//
//  Pokemon.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

struct PokemonList: Decodable {
    let next: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}
