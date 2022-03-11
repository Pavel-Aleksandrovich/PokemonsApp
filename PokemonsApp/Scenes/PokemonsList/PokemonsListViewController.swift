//
//  PokemonsListViewController.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import UIKit

final class PokemonsListViewControllerImpl: UIViewController, PokemonsListViewController {
   
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private let presenter: PokemonsListPresenter
    private let tableView = UITableView()
    private var table: PokemonsTable!
    
    private var offset: Int = 0
    
    init(presenter: PokemonsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        configureView()
        createTableView()
    }
    
    private func createTableView() {
        table = PokemonsTableImpl(tableView: tableView, viewController: self, onCellTappedClosure: { [weak self] url in
            self?.presenter.onCellTapped(url: url)
        })
        loadMorePokemons()
    }
    
    private func loadMorePokemons() {
        table.pageClosure = {
            self.offset += 10
            self.presenter.fetchPokemons(page: self.offset)
        }
    }
    
    func showPokemons(pokemons: PokemonList) {
        table.setPokemons(pokemons: pokemons)
    }
   
    func showError(error: ErrorMessage) {
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    func showProgress() {
        //
    }
    
    func hideProgress() {
        //
    }
    
    func hideError() {
        //
    }
    
    private func configureView() {
        title = Constants.title
    }
}
