//
//  PokemonDetailsViewModelTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonDetailsViewModelTests: XCTestCase {

    private let apiClient: ApiClient = ApiClientURLSession()
    private var pokemon: Pokemon!
    private var service: PokemonService!
    private var imageFetcher: PokemonImageFetcher!
    private var view: MockPokemonDetailsViewController!
    private var viewModel: PokemonDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        
        pokemon = TestPokemon.create()
        service = PokemonApiService(apiClient: apiClient)
        imageFetcher = PokemonImageFetcher(service: service)
        view = MockPokemonDetailsViewController()
        viewModel = PokemonDetailsViewModel(pokemon: pokemon, service: service, imageFetcher: imageFetcher, coordinatorDelegate: nil, viewDelegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        view = nil
        imageFetcher = nil
        service = nil
        pokemon = nil
    }
    
    func testViewModelLoadsPokemonInfoToView() {
        var pokemonInfo: PokemonInfoViewDataType?
        var error: String?
        
        let expectation = expectation(description: "Data updated in the view")
        
        view.dataUpdatedCallback = { mockView in
            pokemonInfo = mockView.pokemonInfo
            error = mockView.error
            
            expectation.fulfill()
        }
        
        viewModel.loadPokemonInfo()
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(pokemonInfo, "Pokemon info should not be nil")
        XCTAssertNil(error, "Error should be nil")
    }

}
