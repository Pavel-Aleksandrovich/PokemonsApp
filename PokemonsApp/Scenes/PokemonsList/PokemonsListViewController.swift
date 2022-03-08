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
    
    private let refreshControl = UIRefreshControl()
    private let presenter: PokemonsListPresenter
    private let tableView = UITableView()
    private var table: PokemonsTable?
    
    var offset: Int = 0
    
    var onCellTappedClosure: ((Poke) -> ())?
    
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
        refreshActrion()
    }
    
    private func refreshActrion() {
        refreshControl.attributedTitle = NSAttributedString(string: "Download")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    private func createTableView() {
        table = PokemonsTable(tableView: tableView, onCellTappedClosure: { [weak self] pokemon in
            self?.onCellTappedClosure?(pokemon)
            self?.presenter.onCellTapped(pokemon: pokemon)
        })
        loadMorePokemons()
    }
    
    private func loadMorePokemons() {
        table?.pageClosure = {
            self.offset += 10
            self.presenter.fetchPokemons(page: self.offset)
        }
    }
    
    func showPokemons(pokemons: [Poke]) {
        table?.setPokemons(pokemons: pokemons)
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
        tableView.register(ProgressCell.self, forCellReuseIdentifier: Constants.progressCellIdentifier)
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
