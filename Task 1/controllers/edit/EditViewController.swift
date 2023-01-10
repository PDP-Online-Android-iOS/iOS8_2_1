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
    var viewModel = EditViewModel()
    
    func loadData(contact: Contact) {
        print(contact)
        self.contact = contact
        etName.text = contact.name
        etNumber.text = contact.number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(contact: contact!)
        
        bindViewModel()
        
    }
    
    func bindViewModel() {
        viewModel.controller = self
    }
    
    func callHomeScreen() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Actions

    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            viewModel.editContact(contact: Contact(id: contact!.id, name: etName.text!, number: etNumber.text!)) { response in
                if response {
                    self.callHomeScreen()
                }
            }
        }
    }
    
    

}
