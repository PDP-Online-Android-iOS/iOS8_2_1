//
//  EditInteractor.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol EditInteractorProtocol {
    
    func apiContactUpdate(contact: Contact)
    
}

class EditInteractor: EditInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: EditResponseProtocol!
    
    func apiContactUpdate(contact: Contact) {
        manager.apiContactEdit(contact: contact, completion: { result in
            self.response.onContactUpdate(edited: true)
        })
    }
    
}
