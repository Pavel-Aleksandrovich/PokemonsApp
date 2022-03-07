//
//  PokemonsInteractor.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

protocol PokemonsInteractor {
    func fetchPokemons(onSuccess: @escaping ([Poke]) -> (),
                       onError: @escaping (ErrorMessage) -> ())
    
    func fetchPokemonByUrl(onSuccess: @escaping (Poke) -> (),
                           onError: @escaping (ErrorMessage) -> ())
}

final class PokemonsInteractorImpl: PokemonsInteractor {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemons(onSuccess: @escaping ([Poke]) -> (),
                       onError: @escaping (ErrorMessage) -> ()) {
        
        networkManager.getPokemons() { result in
            
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
    
    func fetchPokemonByUrl(onSuccess: @escaping (Poke) -> (),
                           onError: @escaping (ErrorMessage) -> ()) {
        
        networkManager.fetchPokemonByUrl { result in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let poke):
                onSuccess(poke)
            }
        }
    }
    
}
