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
    func fetchPokemonBy(url: String, completion: @escaping (FetchResult) -> ())
    func loadPokemonPhotoBy(url: String, completed: @escaping(Data) -> ())
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
    
    func fetchPokemonBy(url: String, completion: @escaping (FetchResult) -> ()) {
        
        networkManager.fetchPokemonBy(url: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let poke):
                completion(.success(poke))
            }
        }
    }
    
    func loadPokemonPhotoBy(url: String, completed: @escaping(Data) -> ()) {
        
        networkManager.loadPokemonPhotoBy(url: url) { data in
            completed(data)
        }
    }
}
