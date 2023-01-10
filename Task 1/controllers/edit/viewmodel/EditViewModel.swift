//
//  EditViewModel.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 10/01/23.
//

import Foundation
import Bond

class EditViewModel {
    
    var controller: BaseViewController!
    
    func editContact(contact: Contact, _ completion: @escaping (Bool) -> Void) {
        controller.showProgress()
        Network.put(url: Network.API_CONTACT_UPDATE + contact.id, params: Network.paramsPostUpdate(contact: contact), handler: { response in
            self.controller.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
}
