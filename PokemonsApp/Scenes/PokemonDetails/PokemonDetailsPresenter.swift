//
//  PokemonDetailsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import Foundation

protocol PokemonDetailsViewController: AnyObject {
    func configure(pokemon: CustomPokemon)
    var deleteOrFavoriteClosure: ((DeleteOrFavorite) -> ())? { get set }
}

protocol PokemonDetailsPresenter {
    func onViewAttached(controller: PokemonDetailsViewController)
}

final class PokemonDetailsPresenterImpl: PokemonDetailsPresenter {
    
    private weak var controller: PokemonDetailsViewController?
    private let router: PokemonDetailsRouter
    private let interactor: PokemonsInteractor
    private let pokemonService: PokemonService
    private let url: String
    private var customPokemon: CustomPokemon?
    
    init(router: PokemonDetailsRouter, interactor: PokemonsInteractor, pokemonService: PokemonService, url: String) {
        self.router = router
        self.interactor = interactor
        self.pokemonService = pokemonService
        self.url = url
    }
    
    func onViewAttached(controller: PokemonDetailsViewController) {
        self.controller = controller
        fetchPokemon()
        configureState()
    }
    
    private func fetchPokemon() {
        interactor.fetchPokemonBy(url: url) { state in
            switch state {
            case .failure(let error):
                print(error)
            case .success(let pokemon):
                self.configure(pokemon: pokemon)
            }
        }
    }

    private func configure(pokemon: Pokemon) {
        let url = pokemon.sprites.frontDefault
        interactor.loadPokemonPhotoBy(url: url) { data in
            self.customPokemon = CustomPokemon(name: pokemon.name, image: data)
            self.controller?.configure(pokemon: self.customPokemon!)
        }
    }
    
    private func configureState() {
        controller?.deleteOrFavoriteClosure = { state in
            switch state {
            case .favorite:
                self.addToFavorite()
            case .delete:
                self.deleteFromFavorite()
            }
        }
    }
    
    private func addToFavorite() {
        pokemonService.createPokemon(sourcePokemon: customPokemon!)
    }
    
    private func deleteFromFavorite() {
        
    }
}
