//
//  PokemonsTable.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import UIKit

final class PokemonsTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "cellIdentifier"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private var tableView: UITableView
    private let onCellTappedClosure: (Poke) -> ()
    private var pokemons: [Poke] = []
    private var isLoading = false
    
    var pageClosure: (() -> ())?
    
    init(tableView: UITableView, onCellTappedClosure: @escaping (Poke) -> ()) {
        self.tableView = tableView
        self.onCellTappedClosure = onCellTappedClosure
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setPokemons(pokemons: [Poke]) {
        self.pokemons.append(contentsOf: pokemons)
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
}
