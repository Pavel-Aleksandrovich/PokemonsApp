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
    
}

final class PokemonFavoritePresenterImpl: PokemonFavoritePresenter {
    
    private weak var controller: PokemonFavoriteViewController?
    private let router: PokemonFavoriteRouter
    
    func onViewAttached(controller: PokemonFavoriteViewController) {
        self.controller = controller
    }
    
    init(router: PokemonFavoriteRouter) {
        self.router = router
    }
    
    
}
