//
//  CreateInteractor.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol CreateInteractorProtocol {
    
    func apiContactCreate(name: String, number: String)
    
}

class CreateInteractor: CreateInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: CreateResponseProtocol!
    
    func apiContactCreate(name: String, number: String) {
        manager.apiContactCreate(name: name, number: number, completion: { result in
            self.response.onContactCreated(created: result)
        })
    }
    
}
