//
//  FavoriteCell.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(pokemon: PokemonEntity) {
        titleLabel.text = pokemon.name
    }
    
    private func configureView() {
        [titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        pokemonTitle.clipsToBounds = true
        addSubview(titleLabel)
    }
    
    private func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
