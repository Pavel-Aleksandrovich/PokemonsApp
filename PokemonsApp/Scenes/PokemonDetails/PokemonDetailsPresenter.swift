//
//  PokemonDetailsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import Foundation

protocol PokemonDetailsViewController: AnyObject {
    func configure(state: State)
}

protocol PokemonDetailsPresenter {
    func onViewAttached(controller: PokemonDetailsViewController)
}

final class PokemonDetailsPresenterImpl: PokemonDetailsPresenter {
    
    private weak var controller: PokemonDetailsViewController?
    private let router: PokemonDetailsRouter
    private let interactor: PokemonsInteractor
    private let pokemon: String
    
    init(router: PokemonDetailsRouter, interactor: PokemonsInteractor, pokemon: String) {
        self.router = router
        self.interactor = interactor
        self.pokemon = pokemon
    }
    
    func onViewAttached(controller: PokemonDetailsViewController) {
        self.controller = controller
        fetchPokemon()
    }
    
    private func fetchPokemon() {
        interactor.fetchPokemonByUrl { poke in
            self.controller?.configure(state: .Success(poke))
        } onError: { error in
            self.controller?.configure(state: .Error(error))
        }
    }
}
