//
//  PokemonsListRouter.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import UIKit

protocol PokemonsListRouter {
    func presentPokemonDetails(url: String)
}

final class PokemonsListRouterImpl: PokemonsListRouter {
    
    weak var controller: UIViewController?
    
    func presentPokemonDetails(url: String) {
        let vc = PokemonDetailsAssembler.assembly(url: url)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
