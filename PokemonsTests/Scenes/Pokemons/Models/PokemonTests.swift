//
//  PokemonTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonTests: XCTestCase {

    func testPokemonListIsCreatedWhenNextIsNull() {
        let pokemonList = TestPokemonList.createWithNullNext()
        
        XCTAssertNotNil(pokemonList, "Pokemon list should not be nil")
    }

}
