//
//  PokemonApiServiceTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 24.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonApiServiceTests: XCTestCase {

    let apiClient = ApiClientURLSession()
    var service: PokemonApiService!
    
    override func setUp() {
        super.setUp()
        
        service = PokemonApiService(apiClient: apiClient)
    }
    
    override func tearDown() {
        super.tearDown()
        
        service = nil
    }
    
    func testPokemonsAreLoaded() {
        var pokemonsList: PokemonList?
        var error: Error?
        
        let expectation = expectation(description: "Get pokemons list")
        
        service.getPokemons { result in
            switch result {
            case .success(let resultPokemonsList):
                pokemonsList = resultPokemonsList
            case .failure(let resultError):
                error = resultError
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(pokemonsList, "Pokemons list should not be nil")
        XCTAssertNil(error, "Erro should be nil")
    }
    
    func testPokemonDetailsAreLoaded() {
        var pokemonDetails: PokemonDetails?
        var error: Error?
        
        let expectation = expectation(description: "Get pokemon details")
        
        service.getPokemonDetails(url: "https://pokeapi.co/api/v2/pokemon/1/") { result in
            switch result {
            case .success(let resultPokemonDetails):
                pokemonDetails = resultPokemonDetails
            case .failure(let resultError):
                error = resultError
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(pokemonDetails, "Pokemon details should not be nil")
        XCTAssertNil(error, "Erro should be nil")
    }
    
    func testPokemonSpeciesAreLoaded() {
        var pokemonSpeices: PokemonSpecies?
        var error: Error?
        
        let expectation = expectation(description: "Get pokemon details")
        
        service.getPokemonSpecies(id: 1) { result in
            switch result {
            case .success(let resultPokemonSpeices):
                pokemonSpeices = resultPokemonSpeices
            case .failure(let resultError):
                error = resultError
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(pokemonSpeices, "Pokemon details should not be nil")
        XCTAssertNil(error, "Erro should be nil")
    }

}
