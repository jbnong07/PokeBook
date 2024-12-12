//
//  ListViewController+Extension.swift
//  PokeBook
//
//  Created by 박진홍 on 12/12/24.
//

import UIKit

extension ListViewController: DetailViewControllerDelegate {
    func didSaveContact() {
        loadContacts() // Core Data에서 데이터를 다시 로드
        contactList.reloadData() // 테이블 뷰 갱신
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.contactID = contacts[indexPath.row].objectID
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact = contacts[indexPath.row]
            coreDataStack.deleteContact(data: contact)
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = contact.name
        content.secondaryText = contact.phoneNumber
        cell.contentConfiguration = content
        
        return cell
    }
}
