//
//  Service.swift
//  PokemonsApp
//
//  Created by pavel mishanin on 08.03.2022.
//

import Foundation
import CoreData

protocol TaskService {
}

final class TaskServiceImpl: TaskService {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    
}
