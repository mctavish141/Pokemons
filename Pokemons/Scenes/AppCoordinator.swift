//
//  AppCoordinator.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let apiClient = ApiClientURLSession()
    
    private lazy var startingCoordinator: Coordinator = {
        return PokemonsCoordinator(navigationController: navigationController, apiClient: apiClient)
    }()
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        startingCoordinator.start()
        
        window.makeKeyAndVisible()
    }
}
