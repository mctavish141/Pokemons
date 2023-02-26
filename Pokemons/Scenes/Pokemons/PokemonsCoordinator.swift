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
        showPokemonListViewController()
    }
    
    private func showPokemonListViewController() {
        // Create MVVM
        let viewController = PokemonListViewController()
        let service = PokemonApiService(apiClient: apiClient)
        let viewModel = PokemonListViewModel(service: service, coordinatorDelegate: self, viewDelegate: viewController)
        viewController.viewModel = viewModel
        
        // Push view controller
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showPokemonDetailsViewController(pokemon: Pokemon, imageFetcher: PokemonImageFetcherType) {
        // Create MVVM
        let viewController = PokemonDetailsViewController()
        let service = PokemonApiService(apiClient: apiClient)
        let viewModel = PokemonDetailsViewModel(pokemon: pokemon, service: service, imageFetcher: imageFetcher, coordinatorDelegate: self, viewDelegate: viewController)
        viewController.viewModel = viewModel
        
        // Push view controller
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension PokemonsCoordinator: PokemonListViewModelCoordinatorDelegate {
    func pokemonSelected(_ pokemon: Pokemon, imageFetcher: PokemonImageFetcherType) {
        showPokemonDetailsViewController(pokemon: pokemon, imageFetcher: imageFetcher)
    }
}

extension PokemonsCoordinator: PokemonDetailsViewModelCoordinatorDelegate {
    
}
