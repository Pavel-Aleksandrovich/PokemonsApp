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
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private let presenter: PokemonsListPresenter
    private let tableView = UITableView()
    private var table: PokemonsTable?
    
    var onCellTappedClosure: ((Int) -> ())?
    
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
        table = PokemonsTable(tableView: tableView, onCellTappedClosure: { [weak self] index in
            self?.onCellTappedClosure?(index)
        })
    }
    
    func showPokemons(pokemons: [Poke]) {
        table?.setPokemons(pokemons: pokemons)
        tableView.reloadData()
    }
   
    func showError(error: ErrorMessage) {
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert,animated: true)
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        //
    }
    
    func hideError() {
        //
    }
    
    private func configureView() {
        title = Constants.title
        
        tableView.register(PokemonCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
