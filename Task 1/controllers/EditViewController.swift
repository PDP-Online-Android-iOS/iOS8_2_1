//
//  EditViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class EditViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etNumber: UITextField!
    
    var contact: Contact?
    
    func loadData(contact: Contact) {
        print(contact)
        self.contact = contact
        etName.text = contact.name
        etNumber.text = contact.number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(contact: contact!)
        
    }

    // MARK: - Actions

    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            apiCall(id: contact!.id, name: etName.text!, number: etNumber.text!)
        }
    }
    
    // MARK: - Api Calls
    
    func apiCall(id: String, name: String, number: String) {
        showProgress()
        
        Network.put(url: Network.API_CONTACT_UPDATE + id, params: Network.paramsPostUpdate(contact: Contact(id: id, name: name, number: number)), handler: { response in
            self.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        })
    }

}
