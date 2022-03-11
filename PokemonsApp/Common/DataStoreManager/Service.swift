//
//  Service.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import Foundation
import CoreData

protocol PokemonService {
    func createPokemon(sourcePokemon: CustomPokemon)
    func getAllPokemons() -> [PokemonEntity]
    func getNumberOfPokemons() -> Int
    func getPokemonBy(id: NSManagedObjectID) -> PokemonEntity?
    func deleteTaskBy(id: NSManagedObjectID)
}

final class PokemonServiceImpl: PokemonService {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func createPokemon(sourcePokemon: CustomPokemon) {
        let pokemon = PokemonEntity(context: coreDataManager.context)
        pokemon.name = sourcePokemon.name
        pokemon.pokemonImage = sourcePokemon.image
        coreDataManager.saveContext()
    }
    
    func getAllPokemons() -> [PokemonEntity] {
        return coreDataManager.getAll()
    }
    
    func getNumberOfPokemons() -> Int {
        return getAllPokemons().count
    }
    
    func getPokemonBy(id: NSManagedObjectID) -> PokemonEntity? {
        return coreDataManager.getBy(id: id)
    }
    
    func deleteTaskBy(id: NSManagedObjectID) {
        let pokemon = coreDataManager.getBy(id: id)
        if pokemon != nil {
            coreDataManager.context.delete(pokemon!)
            coreDataManager.saveContext()
        }
    }
    
}
