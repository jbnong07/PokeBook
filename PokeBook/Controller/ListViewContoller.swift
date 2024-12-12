//
//  ViewController.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ListViewController: UIViewController {
    let contactList: ContactList = ContactList()
    let coreDataStack: CoreDataStack = CoreDataStack.shared
    var contacts: [ContactData] = []//core data에서 가져올 연락처 데이터
    
    override func viewIsAppearing(_ animated: Bool) {
        loadContacts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationTitle()
        setupTableView()
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        view.addSubview(contactList)
        contactList.translatesAutoresizingMaskIntoConstraints = false
        contactList.register(ContactRow.self, forCellReuseIdentifier: "ContactCell")//테이블 뷰에 셀 등록
        
        NSLayoutConstraint.activate([
            contactList.topAnchor.constraint(equalTo: view.topAnchor),
            contactList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contactList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - setup table view
    private func setupTableView() {
        contactList.dataSource = self
        contactList.delegate = self
    }
    
    // MARK: - setup navigation
    private func setupNavigationTitle() {
        navigationItem.title = "Poke Book"
        navigationItem.rightBarButtonItem = setNewContactButton()
    }
    
    // MARK: - New contact button
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
        detailVC.contactID = nil // 새 연락처 추가를 위해 contactID를 비워둠
        detailVC.delegate = self // 델리게이트 지정
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - loadContacts
    func loadContacts() {//무조건 reloadData를 하는 대신 새로운 셀이 추가된 경우에 호출되었을 때와 아닐 때를 구분
        let previousCount = contacts.count
        contacts = coreDataStack.fetchContact()
        let newCount = contacts.count
        
        if newCount > previousCount {
            let newIndexPaths = (previousCount..<newCount).map { IndexPath(row: $0, section: 0) }
            contactList.insertRows(at: newIndexPaths, with: .automatic)
        } else {
            contactList.reloadData()
        }
    }
}

// MARK: - Preview
#Preview {
    UINavigationController(rootViewController: ListViewController())
}
