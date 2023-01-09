//
//  HomePresenter.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol HomePresenterProtocol: HomeRequestProtocol {
    
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
    
}

class HomePresenter: HomePresenterProtocol {
    
    var interactor: HomeInteractor!
    var routing: HomeRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactList() {
        controller.showProgress()
        interactor.apiContactList()
    }
    
    func apiContactDelete(contact: Contact) {
        controller.showProgress()
        interactor.apiContactDelete(contact: contact)
    }
    
    func navigateEditScreen(contact: Contact) {
        routing.navigateEditScreen(contact: contact)
    }
    
    func navigateCreateScreen() {
        routing.navigateCreateScreen()
    }
    
}
