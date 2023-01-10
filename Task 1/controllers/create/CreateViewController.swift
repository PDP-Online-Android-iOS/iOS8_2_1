//
//  CreateViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class CreateViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etNumber: UITextField!
    
    var viewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        // Do any additional setup after loading the view.
    }

    // MARK: - Methods

    func initViews() {
        initNavigation()
        
        bindViewModel()

    }
    
    func bindViewModel() {
        viewModel.controller = self
    }
    
    func callHomeController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initNavigation() {
        title = "Create Contact"
    }
    
    // MARK: - Actions
    
    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            viewModel.createContact(name: etName.text!, number: etNumber.text!) { response in
                if response {
                    self.callHomeController()
                }
            }
        }
    }
    

}
