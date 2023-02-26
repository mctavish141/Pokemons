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
    private var pokemonImage: UIImage?
    private let stackViewMargin = 10.0
    private static let containerViewCornerRadius = 10.0
    private static let containerViewColor = UIColor(red: 245.0/256.0, green: 244.0/256.0, blue: 227.0/256.0, alpha: 0.95)
    private static let stackViewSpacing = 10.0
    private static let descriptionLabelFontSize = 20.0
    private static let heightLabelFontSize = 20.0
    private static let weightabelFontSize = 20.0
    private let pictureViewAspectRatio = 0.25
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = containerViewCornerRadius
        view.backgroundColor = containerViewColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: descriptionLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: heightLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: weightabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupContent(hidden: true)
        setupViews()
        viewModel.loadPokemonInfo()
        loadImage()
    }
    
    private func setupContent(hidden: Bool) {
        containerView.alpha = hidden ? 0.0 : 1.0
    }
    
    private func setupViews() {
        // Container view
        view.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .isActive = true
        containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
            .isActive = true
        containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            .isActive = true
        
        // Picture view
        containerView.addSubview(pictureView)
        
        pictureView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: pictureViewAspectRatio)
            .isActive = true
        
        // Description label
        containerView.addSubview(descriptionLabel)
        
        // Height label
        containerView.addSubview(heightLabel)
        
        // Weight label
        containerView.addSubview(weightLabel)
        
        // Stack view
        containerView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: stackViewMargin)
            .isActive = true
        stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: stackViewMargin)
            .isActive = true
        stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -stackViewMargin)
            .isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -stackViewMargin)
            .isActive = true
        
        stackView.addArrangedSubview(pictureView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(weightLabel)
    }
    
    private func loadImage() {
        viewModel.pokemonImage { data in
            DispatchQueue.main.async {
                if let data = data {
                    self.pokemonImage = UIImage(data: data)
                    self.updateImage()
                }
            }
        }
    }
    
    private func updateData() {
        navigationItem.title = pokemonInfo?.name
        descriptionLabel.text = pokemonInfo?.description
        heightLabel.text = "Height: " + (pokemonInfo?.height ?? "")
        weightLabel.text = "Weight: " + (pokemonInfo?.weight ?? "")
    }
    
    private func updateImage() {
        pictureView.image = pokemonImage
    }
}

extension PokemonDetailsViewController: PokemonDetailsViewModelViewDelegate {
    func update(withPokemonInfo pokemonInfo: PokemonInfoViewDataType) {
        self.pokemonInfo = pokemonInfo
        updateData()
        setupContent(hidden: false)
    }
    
    func update(withPokemonImage pokemonImage: Data) {
        self.pokemonImage = UIImage(data: pokemonImage)
        updateImage()
    }
    
    func update(withError error: String) {
        
    }
}
