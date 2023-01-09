//
//  EditPresenter.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol EditPresenterProtocol {
    
    func apiEditContact(contact: Contact)
    
}

class EditPresenter: EditPresenterProtocol {
    
    var view: EditView!
    var controller: BaseViewController!
    
    func apiEditContact(contact: Contact) {
        controller.showProgress()
        
        Network.put(url: Network.API_CONTACT_UPDATE + contact.id, params: Network.paramsPostUpdate(contact: contact), handler: { response in
            self.controller.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                self.view.onEditContact(edited: true)
            case .failure(let error):
                print(error)
                self.view.onEditContact(edited: false)
            }
        })
    }
    
}
