//
//  ViewController.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ListViewController: UIViewController {
    private let contactList: ContactList = ContactList()
    private let coreDataStack: CoreDataStack = CoreDataStack.shared
    private var contacts: [ContactData] = []//core data에서 가져올 연락처 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationTitle()
        loadContacts()
    }
    
    // MARK: setupLayout
    private func setupLayout() {
        view.addSubview(contactList)
        contactList.translatesAutoresizingMaskIntoConstraints = false
        contactList.delegate = self
        
        NSLayoutConstraint.activate([
            contactList.topAnchor.constraint(equalTo: view.topAnchor),
            contactList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contactList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: setupNavigation
    private func setupNavigationTitle() {
        navigationItem.title = "Poke Bool"
        navigationItem.rightBarButtonItem = setNewContactButton()
    }
    
    private func setNewContactButton() -> UIBarButtonItem {
        let addButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Add", for: .normal)
            button.addAction(UIAction { [weak self] _ in
                guard let self = self else { return }
                self.moveToDetailView()
            }, for: .touchUpInside)
            
            return button
        }()
        
        let barButton = UIBarButtonItem(customView: addButton)
        return barButton
    }
    
    private func moveToDetailView() {
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: loadContacts
    private func loadContacts() {
           contacts = coreDataStack.fetchContact() // Core Data에서 연락처 데이터 로드
           contactList.reloadData()
       }
}

extension ListViewController: UITableViewDelegate {
    
}

