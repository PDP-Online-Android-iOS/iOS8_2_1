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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Methods

    func initViews() {
        initNavigation()
    }
    
    func initNavigation() {
        title = "Create Contact"
    }
    
    // MARK: - API Calls
    
    func apiSaveContact(name: String, number: String) {
        showProgress()
        Network.post(url: Network.API_CONTACT_CREATE, params: Network.paramsPostCreate(contact: Contact(id: "", name: name, number: number)), handler: { response in
            self.hideProgress()
            switch response.result {
            case .success(let data):
                print(data)
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    // MARK: - Actions
    
    @IBAction func onSaveClick(_ sender: Any) {
        if !etName.text!.isEmpty && !etNumber.text!.isEmpty {
            apiSaveContact(name: etName.text!, number: etNumber.text!)
        }
    }
    

}
