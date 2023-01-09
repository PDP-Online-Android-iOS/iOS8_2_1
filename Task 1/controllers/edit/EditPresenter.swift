//
//  EditPresenter.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    
    func apiContactUpdate(contact: Contact)
    
    func navigateHomeScreen()
    
}

class EditPresenter: EditPresenterProtocol {
    
    var interactor: EditInteractor!
    var routing: EditRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactUpdate(contact: Contact) {
        controller.showProgress()
        interactor.apiContactUpdate(contact: contact)
    }
    
    func navigateHomeScreen() {
        routing.navigateHomeScreen()
    }
    
}
