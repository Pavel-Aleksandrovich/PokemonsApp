//
//  PokemonDetailsViewController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import UIKit

final class PokemonDetailsViewControllerImpl: UIViewController, PokemonDetailsViewController {
    
    private let presenter: PokemonDetailsPresenter
    private let pokemonNameLabel = UILabel()
    
    init(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        view.backgroundColor = .white
        configureLayout()
    }
    
    func configure(pokemon: Poke) {
        pokemonNameLabel.text = pokemon.name
    }
    
    private func configureLayout() {
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pokemonNameLabel)
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
