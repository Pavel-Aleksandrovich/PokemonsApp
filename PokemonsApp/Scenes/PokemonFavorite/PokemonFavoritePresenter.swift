//
//  PokemonFavoritePresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

protocol PokemonFavoritePresenter {
    func onViewAttached(controller: PokemonFavoriteViewController)
}

protocol PokemonFavoriteViewController: AnyObject {
    func getPokemons(pokemons: [PokemonEntity])
}

final class PokemonFavoritePresenterImpl: PokemonFavoritePresenter {
    
    private weak var controller: PokemonFavoriteViewController?
    private let router: PokemonFavoriteRouter
    private let pokemonService: PokemonService
    
    func onViewAttached(controller: PokemonFavoriteViewController) {
        self.controller = controller
        getPokemons()
    }
    
    init(router: PokemonFavoriteRouter, pokemonService: PokemonService) {
        self.router = router
        self.pokemonService = pokemonService
    }
    
    private func getPokemons() {
        let pokemons = pokemonService.getAllPokemons()
        controller?.getPokemons(pokemons: pokemons)
    }
}
