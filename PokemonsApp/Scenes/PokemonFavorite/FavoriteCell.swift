//
//  FavoriteCell.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    private let pokemonTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        [pokemonTitle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        pokemonTitle.clipsToBounds = true
        addSubview(pokemonTitle)
    }
    
    private func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            pokemonTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokemonTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
