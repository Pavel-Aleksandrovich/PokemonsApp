//
//  PokemonEntity+CoreDataProperties.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 11.03.2022.
//
//

import Foundation
import CoreData


extension PokemonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonEntity> {
        return NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var pokemonImage: Data?

}

extension PokemonEntity : Identifiable {

}
