//
//  PokemonsTabBarController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class PokemonsTabBarController: UITabBarController {
    
    private let pokemonsList = PokemonsListAssembler.assembly()
    private let pokemonFavorite = PokemonFavoriteAssembler.assembly()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonsList.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        pokemonFavorite.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        viewControllers = [pokemonsList, pokemonFavorite]
    }
}
