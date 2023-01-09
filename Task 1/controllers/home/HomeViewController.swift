//
//  HomeViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

protocol HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(contact: Contact)
}

protocol HomeResponseProtocol {
    func onContactList(contacts: [Contact])
    func onContactDelete(deleted: Bool)
}

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: HomeRequestProtocol!
    
    var items: Array<Contact> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
    }
    
    // MARK: - API Calls
    
    func onContactList(contacts: [Contact]) {
        hideProgress()
        if contacts.count > 0 {
            refreshTableView(contacts: contacts)
        } else {
            // Error
        }
    }
    
    func onContactDelete(deleted: Bool) {
        hideProgress()
        if deleted {
            presenter.apiContactList()
        } else {
            // Error
        }
    }


    // MARK: - Methods
    
    func initViews() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        initNavigation()
        configureViper()
        presenter.apiContactList()
        
    }
    
    func configureViper() {
        let manager = HttpManager()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let routing = HomeRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
        
    }
    
    func refreshTableView(contacts: [Contact]) {
        self.items = contacts
        self.tableView.reloadData()
    }
    
    
    func initNavigation() {
        let refresh = UIImage(systemName: "arrow.triangle.2.circlepath")
        let add = UIImage(systemName: "plus.circle")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard MVC"
    }
    
    func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(contact: Contact) {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.contact = contact
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func leftTapped() {
        presenter.apiContactList()
    }
    
    @objc func rightTapped() {
        callCreateViewController()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        
        cell.tvName.text = item.name
        cell.tvNumber.text = item.number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, contact: items[indexPath.row])
        ])
    }
    
    // MARK: - Contextual Actions
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Edit")
            completion(true)
            self.callEditViewController(contact: contact)
        }
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("Delete")
            completion(true)
            self.presenter.apiContactDelete(contact: contact)
        }
    }
    
}
