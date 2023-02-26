//
//  PokemonCollectionViewCell.swift
//  Pokemons
//
//  Created by Serhii Kopach on 24.02.2023.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private let stackViewMargin = 10.0
    private let nameLabelHeight = 20.0
    private static let colorBackgroundViewCornerRadius = 10.0
    private static let nameLabelFontSize = 20.0
    
    // MARK: - Public properties
    let colorBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = colorBackgroundViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: nameLabelFontSize)
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
        // Color background view
        contentView.addSubview(colorBackgroundView)
        
        colorBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor)
            .isActive = true
        colorBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
            .isActive = true
        colorBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            .isActive = true
        colorBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            .isActive = true
        
        // Picture view
        contentView.addSubview(pictureView)
        
        pictureView.widthAnchor.constraint(equalTo: pictureView.heightAnchor).isActive = true
        
        // Name label
        contentView.addSubview(nameLabel)
        
        nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight).isActive = true
        
        // Stack view
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: stackViewMargin)
            .isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: stackViewMargin)
            .isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -stackViewMargin)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -stackViewMargin)
            .isActive = true
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(pictureView)
    }
}
