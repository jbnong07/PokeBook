//
//  TableView.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ContactList: UITableView, UITableViewDelegate {
    var data: [String] = ["temp"]
    init() {
        super.init(frame: .zero, style: .plain)
        setupContactList()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContact() {
        let newIndex = data.count
        data.append("hello")
        self.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)//행 추가
        DispatchQueue.main.async {//메인스레드에 작업을 예약함
            if let cell = self.cellForRow(at: IndexPath(row: newIndex, section: 0)) as? ContactRow{
                cell.configure()
            }
        }
    }
    
    private func setupContactList() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        self.dataSource = self
        self.register(ContactRow.self, forCellReuseIdentifier: ContactRow.identifier)
    }
}


