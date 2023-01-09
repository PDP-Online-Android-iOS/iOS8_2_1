//
//  HomePresenter.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol HomePresenterProtocol {
    
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
}

class HomePresenter: HomePresenterProtocol {
    
    var homeView: HomeView!
    var controller: BaseViewController!
    
    func apiContactList() {
        controller.showProgress()
        Network.get(url: Network.API_CONTACT_LIST, params: Network.paramsEmpty(), handler: { response in
            self.controller.hideProgress()
            switch response.result {
                case .success:
                    let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                    self.homeView.onLoadContacts(contacts: contacts)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.homeView.onLoadContacts(contacts: [Contact]())
            }
        })
    }
    
    func apiContactDelete(contact: Contact) {
        controller.showProgress()
        Network.del(url: Network.API_CONTACT_DELETE + contact.id, params: Network.paramsEmpty(), handler: { response in
            self.controller.hideProgress()
            switch response.result {
                case .success(let data):
                    print(data)
                    self.homeView.onDeleteContact(deleted: true)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.homeView.onDeleteContact(deleted: false)
            }
        })
    }
    
}
