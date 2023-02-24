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
        
    }
}
