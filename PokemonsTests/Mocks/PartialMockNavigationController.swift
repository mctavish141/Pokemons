//
//  PartialMockNavigationController.swift
//  PokemonsTests
//
//  Created by Serhii Kopach on 26.02.2023.
//

@testable import Pokemons
import UIKit

class PartialMockNavigationController: UINavigationController {
    var lastPushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        lastPushedViewController = viewController
    }
}
