//
//  PokemonDetailsViewController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import UIKit

enum DeleteOrFavorite {
    case delete
    case favorite
}

enum ObtainPostResult {
   case success(post: Pokemon)
   case failure(error: Error)
}

final class PokemonDetailsViewControllerImpl: UIViewController, PokemonDetailsViewController {
    
    private let presenter: PokemonDetailsPresenter
    private let pokemonNameLabel = UILabel()
    private let favoriteImageView = UIImageView()
    private let deleteImageView = UIImageView()
    private let pokemonImageView = UIImageView()
    
    var deleteOrFavoriteClosure: ((DeleteOrFavorite) -> ())?
    
    init(presenter: PokemonDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter.onViewAttached(controller: self)
        
        configureLayout()
        configureActions()
    }
    
    func configure(pokemon: Pokemon) {
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemon.name
            self.loadPhoto(string: pokemon.sprites.frontShiny)
        }
    }
    
    private func loadPhoto(string: String) {
        let imageURL = URL(string: string)!
        
        DispatchQueue.global(qos: .utility).async { [ weak self ] in
            if let data = try? Data(contentsOf: imageURL){
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        favoriteImageView.image = UIImage(systemName: "heart") //heart.fill
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
        deleteOrFavoriteClosure?(.favorite)
    }
    
    @objc func deleteFromFavorite(_ sender: UITapGestureRecognizer) {
        deleteOrFavoriteClosure?(.delete)
    }
    
    private func configureLayout() {
        
        [pokemonNameLabel, favoriteImageView, deleteImageView, pokemonImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pokemonImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor),
            
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 20),
            
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
