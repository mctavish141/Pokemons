//
//  PokemonListViewModelTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonListViewModelTests: XCTestCase {

    private let apiClient: ApiClient = ApiClientURLSession()
    private var service: PokemonService!
    private var view: MockPokemonListViewController!
    private var viewModel: PokemonListViewModel!
    
    override func setUp() {
        super.setUp()
        
        service = PokemonApiService(apiClient: apiClient)
        view = MockPokemonListViewController()
        viewModel = PokemonListViewModel(service: service, coordinatorDelegate: nil, viewDelegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        view = nil
        service = nil
    }
    
    func testViewModelLoadsPokemonsToView() {
        var pokemons: [PokemonViewDataType]?
        var error: String?
        
        let expectation = expectation(description: "Data updated in the view")
        
        view.dataUpdatedCallback = { mockView in
            pokemons = mockView.pokemons
            error = mockView.error
            
            expectation.fulfill()
        }
        
        viewModel.loadPokemons()
        
        wait(for: [expectation], timeout: 15.0)
        XCTAssertNotNil(pokemons, "Pokemons should not be nil")
        XCTAssertNil(error, "Error should be nil")
    }

}
