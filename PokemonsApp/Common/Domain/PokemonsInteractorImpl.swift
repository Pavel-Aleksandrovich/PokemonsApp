//
//  PokemonsInteractor.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

enum FetchResultPokemons {
    case success([Poke])
    case failure(ErrorMessage)
}

enum FetchResult {
    case success(Poke)
    case failure(ErrorMessage)
}

protocol PokemonsInteractor {
    func fetchPokemons(completion: @escaping (FetchResultPokemons) -> ())
    func fetchPokemonByUrl(completion: @escaping (FetchResult) -> ())
}

final class PokemonsInteractorImpl: PokemonsInteractor {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemons(completion: @escaping (FetchResultPokemons) -> ()) {
        
        networkManager.getPokemons() { result in
            
            switch result {
            case.success(let pokemons):
                DispatchQueue.main.async {
                    completion(.success(pokemons))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPokemonByUrl(completion: @escaping (FetchResult) -> ()) {
        
        networkManager.fetchPokemonByUrl { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let poke):
                completion(.success(poke))
            }
        }
    }
    
}
