//
//  PokemonList.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

struct PokemonList: Codable {
    let next: String?
    let results: [Poke]
}

struct Poke : Codable {
    let name: String
    let url: String
}
