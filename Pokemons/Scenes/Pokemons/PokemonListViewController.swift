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
    
    // MARK: - Properties
    private var collectionView: UICollectionView!
    private let cellIdentifier = "PokemonCollectionViewCell"
    private var pokemons: [PokemonViewDataType]?
    private let sideMargin = 10.0
    private let topMargin = 10.0
    private let bottomMargin = 10.0
    private let intercellMargin = 10.0
    private let itemsPerRow = 2
    private let itemAspectRatio = 1.5
    private let colorBackgroundViewColor = UIColor(red: 245.0/256.0, green: 244.0/256.0, blue: 227.0/256.0, alpha: 0.95)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationItem()
        setupCollectionView()
        viewModel.loadPokemons()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Pokemons"
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: topMargin, left: sideMargin, bottom: bottomMargin, right: sideMargin)
        
        let itemSize = itemSize()
        layout.itemSize = itemSize
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        self.collectionView = collectionView
    }
    
    private func itemSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let sideMargins = sideMargin * 2.0
        let intercellMargins = intercellMargin * Double(itemsPerRow - 1)
        let contentWidth = screenWidth - sideMargins - intercellMargins
        let itemWidth = (itemsPerRow > 0) ? contentWidth / Double(itemsPerRow) : contentWidth
        let itemHeight = itemWidth / itemAspectRatio
        
        return CGSize(width: itemWidth, height: itemHeight)
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

extension PokemonListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        if let pokemon = pokemons?[indexPath.item] {
            cell.colorBackgroundView.backgroundColor = colorBackgroundViewColor
            cell.nameLabel.text = pokemon.name
            
            cell.pictureView.image = nil
            viewModel.pokemonImage(forItem: indexPath.item) { imageData in
                DispatchQueue.main.async {
                    if let imageData = imageData,
                       let image = UIImage(data: imageData),
                       let cell = collectionView.cellForItem(at: indexPath) as? PokemonCollectionViewCell {
                        
                        cell.pictureView.image = image
                    }
                }
            }
        }
        
        return cell
    }
}

extension PokemonListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return itemSize()
    }
}

extension PokemonListViewController: PokemonListViewModelViewDelegate {
    func update(withPokemons pokemons: [PokemonViewDataType]) {
        self.pokemons = pokemons
        collectionView.reloadData()
    }
    
    func update(withError error: String) {
        
    }
}
