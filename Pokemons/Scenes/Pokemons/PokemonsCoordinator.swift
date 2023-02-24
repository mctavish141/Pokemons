//
//  PokemonCoordinator.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import UIKit

class PokemonsCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let apiClient: ApiClient
    
    init(navigationController: UINavigationController, apiClient: ApiClient) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func start() {
        // Create MVVM
        let pokemonListViewController = PokemonListViewController()
        let service = PokemonApiService(apiClient: apiClient)
        let pokemonListViewModel = PokemonListViewModel(service: service, coordinatorDelegate: self, viewDelegate: pokemonListViewController)
        pokemonListViewController.viewModel = pokemonListViewModel
        
        // Push view controller
        navigationController.pushViewController(pokemonListViewController, animated: true)
    }
}

extension PokemonsCoordinator: PokemonListViewModelCoordinatorDelegate {
    
}
