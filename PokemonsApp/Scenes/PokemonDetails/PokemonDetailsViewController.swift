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
    private let favoriteImageView = UIImageView()
    private let deleteImageView = UIImageView()
    
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
        configureView()
        configureLayout()
    }
    
    func configure(state: State) {
        switch state {
        case .Success(let poke):
            hundleSuccessState(pokemon: poke)
        case .Error(let error):
            print(error)
        case .Progress:
            print("Progress")
        }
    }
    
    private func hundleSuccessState(pokemon: Poke) {
        pokemonNameLabel.text = pokemon.name
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        favoriteImageView.image = UIImage(systemName: "star") //star.fill
        favoriteImageView.isUserInteractionEnabled = true
        favoriteImageView.contentMode = .scaleAspectFit
        
        deleteImageView.image = UIImage(systemName: "trash")
        deleteImageView.contentMode = .scaleAspectFit
        deleteImageView.isUserInteractionEnabled = true
    }
    
    private func configureActions() {
        
        let favorite = UITapGestureRecognizer(target: self, action: #selector(addToFavorite))
        favoriteImageView.addGestureRecognizer(favorite)
        
        let trash = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorite))
        deleteImageView.addGestureRecognizer(trash)
    }
    
    @objc func addToFavorite(_ sender: UITapGestureRecognizer) {
        print("addToFavorite")
    }
    
    @objc func deleteFromFavorite(_ sender: UITapGestureRecognizer) {
        print("deleteFromFavorite")
    }
    
    private func configureLayout() {
        
        [pokemonNameLabel, favoriteImageView, deleteImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            favoriteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteImageView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 20),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 60),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 60),
            
            deleteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteImageView.topAnchor.constraint(equalTo: favoriteImageView.bottomAnchor, constant: 20),
            deleteImageView.heightAnchor.constraint(equalToConstant: 60),
            deleteImageView.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}
