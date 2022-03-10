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
    private let pokemon: Poke
    
    init(router: PokemonDetailsRouter, interactor: PokemonsInteractor, pokemonService: PokemonService, pokemon: Poke) {
        self.router = router
        self.interactor = interactor
        self.pokemonService = pokemonService
        self.pokemon = pokemon
    }
    
    func onViewAttached(controller: PokemonDetailsViewController) {
        self.controller = controller
        fetchPokemon()
        
        configureState()
    }
    
    private func fetchPokemon() {
        interactor.fetchPokemonBy(url: pokemon.url) { state in
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
            let customPokemon = CustomPokemon(name: pokemon.name, image: data)
            self.controller?.configure(pokemon: customPokemon)
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
        pokemonService.createPokemon(sourcePokemon: pokemon)
    }
    
    private func deleteFromFavorite() {
        
    }
}
