//
//  PokemonsListRouter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import UIKit

protocol PokemonsListRouter {
    func presentPokemonDetails(index: Int)
}

final class PokemonsListRouterImpl: PokemonsListRouter {
    
    weak var controller: UIViewController?
    
    func presentPokemonDetails(index: Int) {
        let vc = PokemonDetailsAssembler.assembly()
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
