//
//  ContactDataBuilder.swift
//  PokeBook
//
//  Created by 박진홍 on 12/12/24.
//
import CoreData

final class ContactDataBuilder {
    private let contactData: ContactData
    
    //별개의 init을 만드는 것과 고민되었는데 더 복잡한 초기화 구문을 가정한다면 중복 방지를 위해 하나로 구현하는 게 낫다고 판단
    init(context: NSManagedObjectContext, contactData: ContactData? = nil) {
        self.contactData = contactData ?? ContactData(context: context)//업데이트를 위한 contactData를 주입 받은 경우 기존 객체 수정 / 없으면 새로운 객체 생성 함
    }
    
    func setImageURL(to url: String) -> ContactDataBuilder {
        contactData.imageURL = url
        return self
    }
    
    func setName(to name: String) -> ContactDataBuilder {
        contactData.name = name
        return self
    }
    
    func setPhonenumber(to number: String) -> ContactDataBuilder {
        contactData.phoneNumber = number
        return self
    }
    
    //빌더 패턴이지만 코어데이터는 정해진 컨텍스트를 활용해 바로 내부에서 객체를 생성하고 수정한 뒤 저장으로 이어지기 때문에 해당 객체를 반환하는 build()메서드는 아직 사용할 일이 없어 구현하지 않음.
}
