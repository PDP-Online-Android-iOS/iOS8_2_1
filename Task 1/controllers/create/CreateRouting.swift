//
//  CreateRouting.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol CreateRoutingProtocol {
    func navigateHomeScreen()
}

class CreateRouting: CreateRoutingProtocol {
    
    weak var viewController: CreateViewController!
    
    func navigateHomeScreen() {
        viewController.callHomeController()
    }
    
}
