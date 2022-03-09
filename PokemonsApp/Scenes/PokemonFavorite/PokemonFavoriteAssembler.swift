//
//  PokemonFavoriteAssembler.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class PokemonFavoriteAssembler {
    
    static func assembly() -> UIViewController {
        
        let router = PokemonFavoriteRouterImpl()
        let pokemonService = PokemonServiceImpl()
        let presenter = PokemonFavoritePresenterImpl(router: router, pokemonService: pokemonService)
        let controller = PokemonFavoriteViewControllerImpl(presenter: presenter)
        
        return controller
    }
}
