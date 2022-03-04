//
//  PokemonDetailsPresenter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import Foundation

protocol PokemonDetailsViewController: AnyObject {
}

protocol PokemonDetailsPresenter {
    func onViewAttached(controller: PokemonDetailsViewController)
}

final class PokemonDetailsPresenterImpl: PokemonDetailsPresenter {
    
    private weak var controller: PokemonDetailsViewController?
    private let router: PokemonDetailsRouter
    
    init(router: PokemonDetailsRouter) {
        self.router = router
    }
    
    func onViewAttached(controller: PokemonDetailsViewController) {
        self.controller = controller
    }
    
    
}
