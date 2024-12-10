//
//  TableView.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ContactList: UITableView, UITableViewDataSource, UITableViewDelegate {
    var data: [String] = ["temp"]
    init() {
        super.init(frame: .zero, style: .plain)
        setupContactList()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //셀을 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactRow.identifier, for: indexPath) as? ContactRow else {
            fatalError("Could not dequeue CustomCell")
        }
//        let productData = data[indexPath.row]
        cell.configure()
       
        return cell
    }
    
    func addContact() {
        let newIndex = data.count
        data.append("hello")
        self.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)//행 추가
        DispatchQueue.main.async {//메인스레드에 작업을 예ㅊ약함
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


