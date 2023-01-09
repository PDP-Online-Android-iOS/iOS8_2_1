//
//  HomeRouting.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol HomeRoutingProtocol {
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

class HomeRouting: HomeRoutingProtocol {
    
    weak var viewController: HomeViewController!
    
    func navigateCreateScreen() {
        viewController.callCreateViewController()
    }
    
    func navigateEditScreen(contact: Contact) {
        viewController.callEditViewController(contact: contact)
    }
    
}
