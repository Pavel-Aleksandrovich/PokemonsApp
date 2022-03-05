//
//  PokemonsInteractor.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

final class PokemonsInteractor {
    // to do init as coreData
    func fetchPokemons(onSuccess: @escaping ([Poke]) -> (),
                       onError: @escaping (ErrorMessage) -> ()) {
        
        NetworkManager.shared.getPokemons() { result in
            
            switch result {
            case.success(let pokemons):
                DispatchQueue.main.async {
                    onSuccess(pokemons)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func fetchPokemonByUrl(url: String) -> Poke {
        NetworkManager.shared.fetchPokemonByUrl(url: url)
    }
    
}
