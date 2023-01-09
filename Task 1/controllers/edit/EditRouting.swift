//
//  EditRouting.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol EditRoutingProtocol {
    func navigateHomeScreen()
}

class EditRouting: EditRoutingProtocol {
    
    weak var viewController: EditViewController!
    
    func navigateHomeScreen() {
        viewController.callHomeScreen()
    }
    
}
