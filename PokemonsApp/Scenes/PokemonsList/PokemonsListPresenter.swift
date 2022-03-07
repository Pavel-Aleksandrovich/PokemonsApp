//
//  PokemonsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

protocol PokemonsListViewController: AnyObject {
    func showPokemons(pokemons: [Poke])
    func showError(error: ErrorMessage)
    func showProgress()
    func hideProgress()
    func hideError()
    var onCellTappedClosure: ((Poke) -> ())? { get set }
}

protocol PokemonsListPresenter {
    func onViewAttached(controller: PokemonsListViewController)
    func onCellTapped(pokemon: Poke)
}

final class PokemonsListPresenterImpl: PokemonsListPresenter {
    
    private weak var controller: PokemonsListViewController?
    private let router: PokemonsListRouter
    private let interactor = PokemonsInteractorImpl()
    private var pokemons: [Poke]?
    
    init(router: PokemonsListRouter) {
        self.router = router
    }
    
    func onViewAttached(controller: PokemonsListViewController) {
        self.controller = controller
        controller.showProgress()
        fetchPokemons()
    }
    
    func onCellTapped(pokemon: Poke) {
        router.presentPokemonDetails(pokemon: pokemon.url)
    }
    
    private func fetchPokemons() {
        interactor.fetchPokemons { pokemons in
            self.controller?.hideProgress()
            self.controller?.showPokemons(pokemons: pokemons)
            self.pokemons = pokemons
        } onError: { error in
            self.controller?.hideProgress()
            self.controller?.showError(error: error)
        }
    }
}
