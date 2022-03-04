//
//  PokemonsListAssembler.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 04.03.2022.
//

import UIKit

final class PokemonsListAssembler {
    
    static func assembly() -> UIViewController {
        
        let router = PokemonsListRouterImpl()
        let presenter = PokemonsListPresenterImpl(router: router)
        let controller = PokemonsListViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
