//
//  EditViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

protocol EditRequestProtocol {
    func apiContactUpdate(contact: Contact)
    
    func navigateHomeScreen()
}

protocol EditResponseProtocol {
    func onContactUpdate(edited: Bool)
}

class EditViewController: BaseViewController, EditResponseProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etNumber: UITextField!
    
    var presenter: EditRequestProtocol!
    
    var contact: Contact?
    
    func loadData(contact: Contact) {
        print(contact)
        self.contact = contact
        etName.text = contact.name
        etNumber.text = contact.number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViper()
        
        loadData(contact: contact!)
        
    }
    
    func callHomeScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureViper() {
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        let routing = EditRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }

    // MARK: - Actions

    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            presenter.apiContactUpdate(contact: Contact(id: contact!.id, name: etName.text!, number: etNumber.text!))
        }
    }
    
    // MARK: - Api Calls
    
    func onContactUpdate(edited: Bool) {
        print(edited)
        if edited {
            dismiss(animated: true, completion: nil)
        } else {
            // Error
        }
    }

}
