//
//  PokemonDetailsViewController.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    // MARK: - View model
    var viewModel: PokemonDetailsViewModelType!
    
    // MARK: - Properties
    private var pokemonInfo: PokemonInfoViewDataType?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewModel.loadPokemonInfo()
    }
    
    private func setupViewController() {
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = pokemonInfo?.name
    }
}

extension PokemonDetailsViewController: PokemonDetailsViewModelViewDelegate {
    func update(withPokemonInfo pokemonInfo: PokemonInfoViewDataType) {
        self.pokemonInfo = pokemonInfo
        setupViewController()
    }
    
    func update(withPokemonImage pokemonImage: Data) {
        
    }
    
    func update(withError error: String) {
        
    }
}
