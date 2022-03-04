//
//  PokemonDetailsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import Foundation

protocol PokemonDetailsViewController: AnyObject {
    func configure(pokemon: Poke)
}

protocol PokemonDetailsPresenter {
    func onViewAttached(controller: PokemonDetailsViewController)
}

final class PokemonDetailsPresenterImpl: PokemonDetailsPresenter {
    
    private weak var controller: PokemonDetailsViewController?
    private let router: PokemonDetailsRouter
    private let interactor = PokemonsInteractor()
    private let pokemon: Poke
    
    init(router: PokemonDetailsRouter, pokemon: Poke) {
        self.router = router
        self.pokemon = pokemon
    }
    
    func onViewAttached(controller: PokemonDetailsViewController) {
        self.controller = controller
        fetPokemon()
    }
    
    private func fetPokemon() {
        controller?.configure(pokemon: pokemon)
    }
}
