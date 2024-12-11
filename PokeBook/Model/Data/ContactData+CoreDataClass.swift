//
//  ContactData+CoreDataClass.swift
//  PokeBook
//
//  Created by 박진홍 on 12/10/24.
//
//

import Foundation
import CoreData


public class ContactData: NSManagedObject {
    static var entityName: String {//Entity 이름을 반복해서 하드코딩하지 않기 위해서 따로 변수를 선언해서 참고 할 수 있게 함
        return String(describing: self)
    }
}
