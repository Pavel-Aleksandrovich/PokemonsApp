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
    var onCellTappedClosure: ((Int) -> ())? { get set }
}

protocol PokemonsListPresenter {
    func onViewAttached(controller: PokemonsListViewController)
}

final class PokemonsListPresenterImpl: PokemonsListPresenter {
    
    private weak var controller: PokemonsListViewController?
    private let router: PokemonsListRouter
    private let interactor = PokemonsInteractor()
    
    init(router: PokemonsListRouter) {
        self.router = router
    }
    
    func onViewAttached(controller: PokemonsListViewController) {
        self.controller = controller
        controller.showProgress()
        onCellTapped()
        
        interactor.fetchPokemons { pokemons in
            self.controller?.hideProgress()
            self.controller?.showPokemons(pokemons: pokemons)
        } onError: { error in
            self.controller?.hideProgress()
            self.controller?.showError(error: error)
        }
    }
    
    private func onCellTapped() {
        controller?.onCellTappedClosure = { [ weak self ] index in
            self?.router.presentPokemonDetails(index: index)
        }
    }
}
