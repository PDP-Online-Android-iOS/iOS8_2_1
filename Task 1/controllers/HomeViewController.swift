//
//  HomeViewController.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 06/01/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: Array<Contact> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        
    }


    // MARK: - Methods
    
    func initViews() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        initNavigation()
        
        items.append(Contact(id: 1, name: "Ogabek", number: "+998 93 203 73 13"))
        items.append(Contact(id: 2, name: "Ogabek", number: "+998 93 203 73 13"))
        items.append(Contact(id: 3, name: "Ogabek", number: "+998 93 203 73 13"))
        items.append(Contact(id: 4, name: "Ogabek", number: "+998 93 203 73 13"))
        items.append(Contact(id: 5, name: "Ogabek", number: "+998 93 203 73 13"))
        items.append(Contact(id: 6, name: "Ogabek", number: "+998 93 203 73 13"))
        items.append(Contact(id: 7, name: "Ogabek", number: "+998 93 203 73 13"))
        
    }
    
    func initNavigation() {
        let refresh = UIImage(systemName: "arrow.triangle.2.circlepath")
        let add = UIImage(systemName: "plus.circle")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "MVC Pattern"
    }
    
    func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController() {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func leftTapped() {
        
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
            self.callEditViewController()
        }
    }
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("Delete")
            completion(true)
        }
    }
    
}