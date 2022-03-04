//
//  PokemonsListRouter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import UIKit

protocol PokemonsListRouter {
    func presentPokemonDetails(pokemon: Poke)
}

final class PokemonsListRouterImpl: PokemonsListRouter {
    
    weak var controller: UIViewController?
    
    func presentPokemonDetails(pokemon: Poke) {
        let vc = PokemonDetailsAssembler.assembly(pokemon: pokemon)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
