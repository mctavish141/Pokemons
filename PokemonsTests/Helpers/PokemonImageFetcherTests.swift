//
//  PokemonImageFetcherTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonImageFetcherTests: XCTestCase {
    
    let apiClient = ApiClientURLSession()
    var service: PokemonService!
    var imageFetcher: PokemonImageFetcher!

    override func setUp() {
        super.setUp()
        
        service = PokemonApiService(apiClient: apiClient)
        imageFetcher = PokemonImageFetcher(service: service)
    }
    
    override func tearDown() {
        super.tearDown()
        
        imageFetcher = nil
        service = nil
    }
    
    func testImageFetcherFetchesImageData() {
        guard let pokemon = TestPokemon.create() else {
            XCTFail("Pokemon should not be nil")
            return
        }
        
        var data: Data?
        
        let expectation = expectation(description: "Fetch pokemon image data")
        
        imageFetcher.fetchPokemonImage(forPokemon: pokemon) { resultData in
            data = resultData
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(data, "Data should not be nil")
    }

}
