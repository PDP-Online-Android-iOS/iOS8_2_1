//
//  CreateViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class CreateViewController: BaseViewController, CreateView {
    
    // MARK: - Outlets
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etNumber: UITextField!
    
    var presenter: CreatePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        // Do any additional setup after loading the view.
    }

    // MARK: - Methods

    func initViews() {
        initNavigation()
        
        presenter = CreatePresenter()
        presenter.view = self
        presenter.controller = self

    }
    
    func initNavigation() {
        title = "Create Contact"
    }
    
    // MARK: - API Calls
    
    func onCreateContact(created: Bool) {
        if created {
            self.navigationController?.popViewController(animated: true)
        } else {
            // Error
            print("Error")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            self.presenter.apiCreateContact(name: etName.text!, number: etNumber.text!)
        }
    }
    

}
