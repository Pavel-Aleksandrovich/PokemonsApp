//
//  PokemonsTabBarController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

class PokemonsTabBarController: UITabBarController {
    
    var pokemonsList = PokemonsListAssembler.assembly()
    var pokemonFavorite = PokemonFavoriteAssembler.assembly()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonsList.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        pokemonFavorite.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        viewControllers = [pokemonsList, pokemonFavorite]
    }
}
