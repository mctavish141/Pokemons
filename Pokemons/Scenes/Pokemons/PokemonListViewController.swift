//
//  PokemonListViewController.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    // MARK: - View model
    var viewModel: PokemonListViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Pokemons"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PokemonListViewController: PokemonListViewModelViewDelegate {
    
}
