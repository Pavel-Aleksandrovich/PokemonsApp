//
//  PokemonFavoriteViewController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class PokemonFavoriteViewControllerImpl: UIViewController, PokemonFavoriteViewController {
    
    private let presenter: PokemonFavoritePresenter
    
    init(presenter: PokemonFavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.onViewAttached(controller: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
