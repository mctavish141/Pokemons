//
//  PokemonCollectionViewCell.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func addViews() {
        contentView.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contentView.addSubview(pictureView)
        
        pictureView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        pictureView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        pictureView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
}
