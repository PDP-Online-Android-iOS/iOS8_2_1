//
//  HomeViewModel.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 10/01/23.
//

import Foundation
import Bond

class HomeViewModel {
    var controller: BaseViewController!
    let items = Observable<[Contact]>([])
    
    func apiContactList() {
        controller.showProgress()
        Network.get(url: Network.API_CONTACT_LIST, params: Network.paramsEmpty(), handler: { response in
            self.controller.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                self.items.value = contacts
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func apiContactDelete(contact: Contact, handler: @escaping (Bool) -> Void) {
        controller.showProgress()
        Network.del(url: Network.API_CONTACT_DELETE + contact.id, params: Network.paramsEmpty(), handler: { response in
            self.controller.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                let contacts = try! JSONDecoder().decode(Contact.self, from: response.data!)
                handler(true)
            case .failure(let error):
                print(error)
                handler(false)
            }
        })
    }
    
}
