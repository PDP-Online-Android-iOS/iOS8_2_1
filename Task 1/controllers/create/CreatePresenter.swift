//
//  CreatePresenter.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    
    func apiContactCreate(name: String, number: String)
    
    func navigateHomeScreen()
    
}

class CreatePresenter: CreatePresenterProtocol {
    
    var interactor: CreateInteractor!
    var routing: CreateRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactCreate(name: String, number: String) {
        controller.showProgress()
        interactor.apiContactCreate(name: name, number: number)
    }
    
    func navigateHomeScreen() {
        routing.navigateHomeScreen()
    }
    
}
