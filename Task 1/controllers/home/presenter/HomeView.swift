//
//  HomeView.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 09/01/23.
//

import Foundation

protocol HomeView {
    
    func onLoadContacts(contacts: [Contact])
    func onDeleteContact(deleted: Bool)
    
}
