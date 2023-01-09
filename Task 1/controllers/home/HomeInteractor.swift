//
//  HomeInteractor.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol HomeInteractorProtocol {
    
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
}

class HomeInteractor: HomeInteractorProtocol {
    
    var manager: HttpManagerProtocol!
    var response: HomeResponseProtocol!
    
    func apiContactList() {
        manager.apiContactList(completion: { result in
            self.response.onContactList(contacts: result)
        })
    }
    
    func apiContactDelete(contact: Contact) {
        manager.apiContactDelete(contact: contact, completion: { result in
            self.response.onContactDelete(deleted: result)
        })
    }
    
}
