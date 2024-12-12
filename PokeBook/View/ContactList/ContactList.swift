//
//  TableView.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ContactList: UITableView{
    var data: [ContactData] = []
    private let coreDataStack: CoreDataStack = CoreDataStack.shared
    init() {
        super.init(frame: .zero, style: .plain)
        setupContactList()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadContacts() {
        data = coreDataStack.fetchContact()
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func addContact(contact: ContactDataInfo) {
        coreDataStack.addContactByBuilder { builder in
            builder.setName(to: contact.name)
                .setPhonenumber(to: contact.phoneNumber)
            if let imageURL = contact.imageURL {
                builder.setImageURL(to: imageURL)
            }
        }
        loadContacts()
    }
    
    private func setupContactList() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        self.register(ContactRow.self, forCellReuseIdentifier: ContactRow.identifier)
    }
}


