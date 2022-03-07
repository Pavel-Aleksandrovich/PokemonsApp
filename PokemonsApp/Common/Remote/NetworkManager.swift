//
//  NetworkManager.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

final class NetworkManager {
    
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=10"
    
    func getPokemons(page: Int, completed: @escaping(FetchResultPokemons) -> ()) {
        
        let endpoint = baseUrl + "&offset=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PokemonList.self, from: data)
                let pokemons = response.results
                completed(.success(pokemons))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func fetchPokemonByUrl(completed: @escaping(FetchResult) -> ()) {
        completed(.success(Poke(name: "black", url: "")))
    }
}

