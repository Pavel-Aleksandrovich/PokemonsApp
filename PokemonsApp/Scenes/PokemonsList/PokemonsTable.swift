//
//  PokemonsTable.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import UIKit

protocol PokemonsTable {
    func setPokemons(pokemons: PokemonList)
    var pageClosure: (() -> ())? { get set }
}

final class PokemonsTableImpl: NSObject, PokemonsTable, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private let refreshControl: RefreshControl
    private weak var viewController: UIViewController?
    private let tableView: UITableView
    private let onCellTappedClosure: (Poke) -> ()
    private var pokemons: [Poke] = []
    private var isLoading = false
    
    var pageClosure: (() -> ())?
    
    init(tableView: UITableView, viewController: UIViewController, onCellTappedClosure: @escaping (Poke) -> ()) {
        self.tableView = tableView
        self.viewController = viewController
        self.onCellTappedClosure = onCellTappedClosure
        refreshControl = RefreshControl(tableView: tableView)
        super.init()
        configureTableView()
    }
    
    func setPokemons(pokemons: PokemonList) {
        self.pokemons.append(contentsOf: pokemons.results)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            loadMoreData()
        }
    }
    
    private func loadMoreData() {
        if !isLoading {
            isLoading = true
            DispatchQueue.global().async {
                sleep(2)
                self.pageClosure?()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! PokemonCell
            cell.configure(note: pokemons[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.progressCellIdentifier, for: indexPath) as! ProgressCell
            cell.activityStartAnimating()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pokemons.count
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        onCellTappedClosure(pokemons[indexPath.row])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PokemonCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.register(ProgressCell.self, forCellReuseIdentifier: Constants.progressCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let view = viewController?.view else { return }
        
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
