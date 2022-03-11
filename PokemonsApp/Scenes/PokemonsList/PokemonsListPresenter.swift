//
//  PokemonsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

protocol PokemonsListViewController: AnyObject {
    func showPokemons(pokemons: PokemonList)
    func showError(error: ErrorMessage)
    func showProgress()
    func hideProgress()
    func hideError()
}

protocol PokemonsListPresenter {
    func onViewAttached(controller: PokemonsListViewController)
    func onCellTapped(url: String)
    func fetchPokemons(page: Int)
}

final class PokemonsListPresenterImpl: PokemonsListPresenter {
    
    private weak var controller: PokemonsListViewController?
    private let router: PokemonsListRouter
    private let interactor: PokemonsInteractor
    private var pokemons: [Poke]?
    
    init(router: PokemonsListRouter, interactor: PokemonsInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func onViewAttached(controller: PokemonsListViewController) {
        self.controller = controller
        controller.showProgress()
    }
    
    func onCellTapped(url: String) {
        router.presentPokemonDetails(url: url)
    }
    
    func fetchPokemons(page: Int) {
        interactor.fetchPokemons(page: page) { result in
            switch result {
            case .success(let pokemons):
                self.controller?.hideProgress()
                self.controller?.showPokemons(pokemons: pokemons)
//                self.pokemons = pokemons
            case .failure(let error):
                self.controller?.hideProgress()
                self.controller?.showError(error: error)
            }
        }
    }
}
