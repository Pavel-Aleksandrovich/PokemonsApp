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
    
    init(tableView: UITableView, onCellTappedClosure: @escaping (Poke) -> ()) {
        self.tableView = tableView
        self.onCellTappedClosure = onCellTappedClosure
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setPokemons(pokemons: [Poke]) {
        self.pokemons = pokemons
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! PokemonCell
            cell.configure(note: pokemons[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.progressCellIdentifier, for: indexPath) as! ProgressCell
            cell.activityIsActivate(true)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            
//            self.getPokemons()
        }
    }
}
