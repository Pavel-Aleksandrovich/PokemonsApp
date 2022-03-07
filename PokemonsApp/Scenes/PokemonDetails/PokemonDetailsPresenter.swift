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
    private let interactor = PokemonsInteractorImpl()
    private let pokemon: String
    
    init(router: PokemonDetailsRouter, pokemon: String) {
        self.router = router
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
