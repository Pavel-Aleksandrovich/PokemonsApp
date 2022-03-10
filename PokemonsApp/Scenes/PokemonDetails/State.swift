//
//  State.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 05.03.2022.
//

import Foundation

enum State {
    case Success(Pokemon)
    case Error(ErrorMessage)
    case Progress
}
