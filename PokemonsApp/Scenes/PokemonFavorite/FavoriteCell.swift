//
//  FavoriteCell.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    private let titleLabel = UILabel()
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
        titleLabel.text = pokemon.name
        guard let data = pokemon.pokemonImage else { return }
        pokemonImageView.image = UIImage(data: data)
    }
    
    private func configureView() {
        [titleLabel, pokemonImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func configureLayoutConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            pokemonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            pokemonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.9),
            pokemonImageView.widthAnchor.constraint(equalToConstant: self.bounds.height * 0.9),
        ])
    }
}
