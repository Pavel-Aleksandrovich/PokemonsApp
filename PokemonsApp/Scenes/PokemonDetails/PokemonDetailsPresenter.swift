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
        interactor.fetchPokemonByUrl { result in
            switch result {
            case .success(let poke):
                self.controller?.configure(state: .Success(poke))
            case .failure(let error):
                self.controller?.configure(state: .Error(error))
            }
        }
    }
}
