//
//  PokemonList+Tests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import Foundation
@testable import Pokemons

typealias TestPokemonList = PokemonList

extension TestPokemonList {
    static func createWithNullNext() -> TestPokemonList? {
        let json: [String: Any] = [
            "next": NSNull(),
            "results": []
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            return nil
        }
        
        let pokemonList = try? JSONDecoder().decode(TestPokemonList.self, from: data)
        
        return pokemonList
    }
}
