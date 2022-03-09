//
//  PokemonDetailsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import Foundation

protocol PokemonDetailsViewController: AnyObject {
    func configure(state: State)
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
//        fetchPokemon()
        controller.configure(state: .Success(pokemon))
        configureState()
    }
    
    private func fetchPokemon() {
        interactor.fetchPokemonByUrl { result in
            switch result {
            case .success(let poke):
                self.controller?.configure(state: .Success(poke))
            case .failure(let error):
                self.controller?.configure(state: .Error(error))
            }
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
