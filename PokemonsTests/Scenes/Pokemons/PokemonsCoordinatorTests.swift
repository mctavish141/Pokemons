//
//  PokemonsCoordinatorTests.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

import XCTest
@testable import Pokemons

class PokemonsCoordinatorTests: XCTestCase {

    let apiClient: ApiClient = ApiClientURLSession()
    var navigationController: PartialMockNavigationController!
    var coordinator: PokemonsCoordinator!
    
    override func setUp() {
        super.setUp()
        
        navigationController = PartialMockNavigationController()
        coordinator = PokemonsCoordinator(navigationController: navigationController, apiClient: apiClient)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coordinator = nil
        navigationController = nil
    }
    
    func testPokemonListViewControllerIsPushedWhenPokemonsCoordinatorStarts() {
        coordinator.start()
        
        let lastPushedViewController = navigationController.lastPushedViewController as? PokemonListViewController
        
        XCTAssertNotNil(lastPushedViewController, "Last pushed view controller should not be nil")
    }
}
