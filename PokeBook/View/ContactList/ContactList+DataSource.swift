//
//  ContactList+DataSource.swift
//  PokeBook
//
//  Created by 박진홍 on 12/12/24.
//어떤 식으로 파일을 분리하고 네이밍 컨벤션을 하는지 보고 따라서 분리해본 파일.

import UIKit

extension ContactList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    //셀을 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactRow.identifier, for: indexPath) as? ContactRow else {
            fatalError("Failed to dequeue CustomCell")
        }
//        let productData = data[indexPath.row]
        cell.configure()
       
        return cell
    }
}
