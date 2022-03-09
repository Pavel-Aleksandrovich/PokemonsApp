//
//  PokemonFavoriteTable.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class PokemonFavoriteTable: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIdentifier = "FavoriteCell"
        static let progressCellIdentifier = "progressCellIdentifier"
        static let heightForRow: CGFloat = 80
        static let title = "Pokemons"
    }
    
    private var tableView: UITableView
    private var pokemons: [PokemonEntity] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setPokemons(pokemons: [PokemonEntity]) {
        self.pokemons = pokemons
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! FavoriteCell
        
        cell.configure(pokemon: pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
}
