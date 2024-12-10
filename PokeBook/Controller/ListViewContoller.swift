//
//  ViewController.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

class ListViewController: UIViewController {
    let contactList: ContactList = ContactList()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContactList()
    }
    
    private func setupContactList() {
        view.addSubview(contactList)
        contactList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactList.topAnchor.constraint(equalTo: view.topAnchor),
            contactList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contactList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contactList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

