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
        let networkManager = NetworkManager()
        let interactor = PokemonsInteractorImpl(networkManager: networkManager)
        let presenter = PokemonsListPresenterImpl(router: router, interactor: interactor)
        let controller = PokemonsListViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
