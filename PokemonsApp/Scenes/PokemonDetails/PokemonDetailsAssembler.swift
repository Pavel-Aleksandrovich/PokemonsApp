//
//  PokemonDetailsAssembler.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import UIKit

final class PokemonDetailsAssembler {
    
    static func assembly(url: String) -> UIViewController {
        
        let router = PokemonDetailsRouterImpl()
        let networkManager = NetworkManager()
        let interactor = PokemonsInteractorImpl(networkManager: networkManager)
        let pokemonService = PokemonServiceImpl()
        let presenter = PokemonDetailsPresenterImpl(router: router, interactor: interactor, pokemonService: pokemonService, url: url)
        let controller = PokemonDetailsViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
