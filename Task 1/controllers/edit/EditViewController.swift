//
//  EditViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class EditViewController: BaseViewController, EditView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etNumber: UITextField!
    
    var presenter: EditPresenter!
    
    var contact: Contact?
    
    func loadData(contact: Contact) {
        print(contact)
        self.contact = contact
        etName.text = contact.name
        etNumber.text = contact.number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
        loadData(contact: contact!)
        
    }
    
    func initViews() {
        presenter = EditPresenter()
        presenter.view = self
        presenter.controller = self
    }

    // MARK: - Actions

    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            presenter.apiEditContact(contact: Contact(id: contact!.id, name: etName.text!, number: etNumber.text!))
        }
    }
    
    // MARK: - Api Calls
    
    func onEditContact(edited: Bool) {
        print(edited)
        if edited {
            dismiss(animated: true, completion: nil)
        } else {
            // Error
        }
    }

}
