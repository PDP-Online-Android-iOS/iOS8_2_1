//
//  CreateViewModel.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 10/01/23.
//

import Foundation
import Bond

class CreateViewModel {
    
    var controller: BaseViewController!
    
    func createContact(name: String, number: String, _ completion: @escaping (Bool) -> Void) {
        controller.showProgress()
        Network.post(url: Network.API_CONTACT_CREATE, params: Network.paramsPostCreate(contact: Contact(id: "", name: name, number: number)), handler: { response in
            self.controller.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                let contacts = try! JSONDecoder().decode(Contact.self, from: response.data!)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
}
