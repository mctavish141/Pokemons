//
//  Pokemon+Tests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import Foundation
@testable import Pokemons

typealias TestPokemon = Pokemon

extension TestPokemon {
    static func create() -> TestPokemon? {
        let json: [String: Any] = [
            "name": "bulbasaur",
            "url": "https://pokeapi.co/api/v2/pokemon/1/"
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            return nil
        }
        
        let pokemon = try? JSONDecoder().decode(TestPokemon.self, from: data)
        
        return pokemon
    }
}
