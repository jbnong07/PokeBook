//
//  ContactData+CoreDataProperties.swift
//  PokeBook
//
//  Created by 박진홍 on 12/10/24.
//
//

import Foundation
import CoreData


extension ContactData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactData> {
        return NSFetchRequest<ContactData>(entityName: "ContactData")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}

extension ContactData : Identifiable {

}
