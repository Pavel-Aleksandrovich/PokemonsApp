//
//  State.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 05.03.2022.
//

import Foundation

enum State {
    case Success(Poke)
    case Error(ErrorMessage)
    case Progress
}
