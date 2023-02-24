//
//  PokemonDetails.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

struct PokemonDetails: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
}

struct PokemonSprites: Decodable {
    let front_default: String
}
