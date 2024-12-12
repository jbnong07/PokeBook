//
//  TableView.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ContactList: UITableView{
    private let coreDataStack: CoreDataStack = CoreDataStack.shared
    init() {
        super.init(frame: .zero, style: .plain)
        setupContactList()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContact(contact: ContactDataInfo) {
        coreDataStack.addContactByBuilder { builder in
            builder.setName(to: contact.name)
                .setPhonenumber(to: contact.phoneNumber)
            if let imageURL = contact.imageURL {
                builder.setImageURL(to: imageURL)
            }
        }
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    private func setupContactList() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        self.register(ContactRow.self, forCellReuseIdentifier: ContactRow.identifier)
    }
}


