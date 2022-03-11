//
//  PokemonFavoritePresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

protocol PokemonFavoritePresenter {
    func onViewAttached(controller: PokemonFavoriteViewController)
    func complitionTapped(index: Int)
}

protocol PokemonFavoriteViewController: AnyObject {
    func getPokemons(pokemons: [PokemonEntity])
}

final class PokemonFavoritePresenterImpl: PokemonFavoritePresenter {
    
    private weak var controller: PokemonFavoriteViewController?
    private let router: PokemonFavoriteRouter
    private let pokemonService: PokemonService
    private var pokemons: [PokemonEntity] = []
    
    init(router: PokemonFavoriteRouter, pokemonService: PokemonService) {
        self.router = router
        self.pokemonService = pokemonService
    }
    
    func onViewAttached(controller: PokemonFavoriteViewController) {
        self.controller = controller
        getPokemons()
    }
    
    func complitionTapped(index: Int) {
        pokemonService.deleteTaskBy(id: pokemons[index].objectID)
    }
    
    private func getPokemons() {
        pokemons = pokemonService.getAllPokemons()
        controller?.getPokemons(pokemons: pokemons)
    }
}
