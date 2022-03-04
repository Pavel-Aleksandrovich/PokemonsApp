//
//  PokemonDetailsAssembler.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import UIKit

final class PokemonDetailsAssembler {
    
    static func assembly(pokemon: Poke) -> UIViewController {
        let router = PokemonDetailsRouterImpl()
        let presenter = PokemonDetailsPresenterImpl(router: router, pokemon: pokemon)
        let controller = PokemonDetailsViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
