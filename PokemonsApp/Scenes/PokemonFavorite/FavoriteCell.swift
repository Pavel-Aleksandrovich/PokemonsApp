//
//  FavoriteCell.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    private let pokemonNameLabel = UILabel()
    private let pokemonImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(pokemon: PokemonEntity) {
        pokemonNameLabel.text = pokemon.name
        guard let data = pokemon.pokemonImage else { return }
        pokemonImageView.image = UIImage(data: data)
    }
    
    private func configureView() {
        [pokemonNameLabel, pokemonImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            pokemonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            pokemonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: self.bounds.height * 2),
            pokemonImageView.widthAnchor.constraint(equalToConstant: self.bounds.height * 2),
        ])
    }
}
