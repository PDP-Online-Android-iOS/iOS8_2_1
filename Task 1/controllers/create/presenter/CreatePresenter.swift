//
//  CreatePresenter.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol CreatePresenterProtocol {
    
    func apiCreateContact(name: String, number: String)
    
}

class CreatePresenter: CreatePresenterProtocol {
    
    var view: CreateView!
    var controller: BaseViewController!
    
    func apiCreateContact(name: String, number: String) {
        controller.showProgress()
        Network.post(url: Network.API_CONTACT_CREATE, params: Network.paramsPostCreate(contact: Contact(id: "", name: name, number: number)), handler: { response in
            self.controller.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                self.view.onCreateContact(created: true)
            case .failure(let error):
                print(error.localizedDescription)
                self.view.onCreateContact(created: false)
            }
        })
    }
    
}
