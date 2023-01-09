//
//  HttpManager.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol HttpManagerProtocol {
    
    func apiContactList(completion: @escaping ([Contact]) -> Void)
    func apiContactDelete(contact: Contact, completion: @escaping (Bool) -> Void)
    func apiContactEdit(contact: Contact, completion: @escaping (Bool) -> Void)
    func apiContactCreate(name: String, number: String, completion: @escaping (Bool) -> Void)
    
}

class HttpManager: HttpManagerProtocol {
    
    func apiContactEdit(contact: Contact, completion: @escaping (Bool) -> Void) {
        Network.put(url: Network.API_CONTACT_UPDATE + contact.id, params: Network.paramsPostCreate(contact: contact), handler: { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func apiContactList(completion: @escaping ([Contact]) -> Void) {
        Network.get(url: Network.API_CONTACT_LIST, params: Network.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                completion(contacts)
            case .failure(let error):
                print(error)
                completion([Contact]())
            }
        })
    }
    
    func apiContactCreate(name: String, number: String, completion: @escaping (Bool) -> Void) {
        Network.post(url: Network.API_CONTACT_CREATE, params: Network.paramsPostCreate(contact: Contact(id: "", name: name, number: number)), handler: { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func apiContactDelete(contact: Contact, completion: @escaping (Bool) -> Void) {
        Network.del(url: Network.API_CONTACT_DELETE + contact.id, params: Network.paramsEmpty(), handler: { response in
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode(Contact.self, from: response.data!)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
}
