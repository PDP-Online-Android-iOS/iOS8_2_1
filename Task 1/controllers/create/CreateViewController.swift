//
//  CreateViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(name: String, number: String)
    
    func navigateHomeScreen()
}

protocol CreateResponseProtocol {
    func onContactCreated(created: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etNumber: UITextField!
    
    var presenter: CreateRequestProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        // Do any additional setup after loading the view.
    }

    // MARK: - Methods

    func initViews() {
        initNavigation()
        
        configureViper()

    }
    
    func configureViper() {
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        let routing = CreateRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
        
    }
    
    func callHomeController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initNavigation() {
        title = "Create Contact"
    }
    
    // MARK: - API Calls
    
    func onContactCreated(created: Bool) {
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
            self.presenter.apiContactCreate(name: etName.text!, number: etNumber.text!)
        }
    }
    

}
