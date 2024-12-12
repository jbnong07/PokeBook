//
//  TableViewCell.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit

final class ContactRow: UITableViewCell {
    static let identifier: String = "ContactRow" //재사용을 위한 식별자
    private let cellRow: ContactRowDetail = ContactRowDetail()//셀에 들어갈 세부사항
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContactRow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with contact: ContactData) {
        cellRow.profileImage.setImage(url: contact.imageURL)
        cellRow.name.text = contact.name
        cellRow.number.text = contact.phoneNumber
    }
    
    private func setupContactRow() {
        contentView.addSubview(cellRow)
        setupLayout()
    }
    private func setupLayout() {
        cellRow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellRow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellRow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cellRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
