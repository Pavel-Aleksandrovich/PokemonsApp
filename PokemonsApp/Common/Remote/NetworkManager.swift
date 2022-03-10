//
//  NetworkManager.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 02.03.2022.
//

import Foundation

enum ObtainResult {
    case success(PokemonList)
    case failure(ErrorMessage)
}

final class NetworkManager {
    
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=10"
    
    func getPokemons(page: Int, completed: @escaping(ObtainResult) -> ()) {
        
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
                completed(.success(response))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func fetchPokemonBy(url: String, completed: @escaping(FetchResult) -> ()) {
        
        guard let url = URL(string: url) else {
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
                let response = try JSONDecoder().decode(Pokemon.self, from: data)
                completed(.success(response))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func loadPokemonPhotoBy(url: String, completed: @escaping(Data) -> ()) {
        let imageURL = URL(string: url)!
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    completed(data)
                }
            }
        }
    }
}

