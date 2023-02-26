//
//  PokemonInfoFetcherTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonInfoFetcherTests: XCTestCase {

    let apiClient = ApiClientURLSession()
    var service: PokemonService!
    var infoFetcher: PokemonInfoFetcher!

    override func setUp() {
        super.setUp()
        
        service = PokemonApiService(apiClient: apiClient)
        infoFetcher = PokemonInfoFetcher(service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        
        infoFetcher = nil
        service = nil
    }
    
    func testInfoFetcherFetchesInfo() {
        guard let pokemon = TestPokemon.create() else {
            XCTFail("Pokemon should not be nil")
            return
        }
        
        var pokemonInfo: PokemonInfo?
        var error: Error?
        
        let expectation = expectation(description: "Fetch pokemon info")
        
        infoFetcher.fetchPokemonInfo(forPokemon: pokemon) { result in
            switch result {
            case .success(let resultPokemonInfo):
                pokemonInfo = resultPokemonInfo
            case .failure(let resultError):
                error = resultError
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(pokemonInfo, "Pokemon info should not be nil")
        XCTAssertNil(error, "Error should be nil")
    }

}
