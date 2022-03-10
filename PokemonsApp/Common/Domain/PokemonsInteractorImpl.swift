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
    case success(Pokemon)
    case failure(ErrorMessage)
}

protocol PokemonsInteractor {
    func fetchPokemons(page: Int, completion: @escaping (ObtainResult) -> ())
    func fetchPokemonByUrl(url: String, completion: @escaping (FetchResult) -> ())
}

final class PokemonsInteractorImpl: PokemonsInteractor {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemons(page: Int, completion: @escaping (ObtainResult) -> ()) {
        
        networkManager.getPokemons(page: page) { result in
            
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
    
    func fetchPokemonByUrl(url: String, completion: @escaping (FetchResult) -> ()) {
        
        networkManager.fetchPokemonByUrl(url: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let poke):
                completion(.success(poke))
            }
        }
    }
    
}
