//
//  HomeViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
    }
    
    // MARK: - API Calls
    
    


    // MARK: - Methods
    
    func initViews() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        bindViewModel()
        
        initNavigation()
        
        viewModel.apiContactList()
        
    }
    
    func bindViewModel() {
        viewModel.controller = self
        viewModel.items.bind(to: self) { strongSelf, _ in
            strongSelf.tableView.reloadData()
        }
    }
    
    func initNavigation() {
        let refresh = UIImage(systemName: "arrow.triangle.2.circlepath")
        let add = UIImage(systemName: "plus.circle")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Storyboard MVVM"
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
        viewModel.apiContactList()
    }
    
    @objc func rightTapped() {
        callCreateViewController()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items.value[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        
        cell.tvName.text = item.name
        cell.tvNumber.text = item.number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, contact: viewModel.items.value[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, contact: viewModel.items.value[indexPath.row])
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
            self.viewModel.apiContactDelete(contact: contact, handler: { response in
                self.viewModel.apiContactList()
            })
        }
    }
    
}
