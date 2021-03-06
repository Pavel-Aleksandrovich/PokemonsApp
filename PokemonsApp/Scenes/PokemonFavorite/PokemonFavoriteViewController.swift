//
//  PokemonFavoriteViewController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class PokemonFavoriteViewControllerImpl: UIViewController, PokemonFavoriteViewController {

    private enum Constants {
    }
    
    private let presenter: PokemonFavoritePresenter
    private let tableView = UITableView()
    private var table: PokemonFavoriteTable?
    
    init(presenter: PokemonFavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        presenter.onViewAttached(controller: self)
    }
    
    func getPokemons(pokemons: [PokemonEntity]) {
        table?.setPokemons(pokemons: pokemons)
    }
    
    private func createTableView() {
        table = PokemonFavoriteTable(tableView: tableView, viewController: self, complitionHandler: { index in
            self.presenter.complitionTapped(index: index)
        })
    }
}
