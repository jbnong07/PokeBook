//
//  CoreDataStack.swift
//  PokeBook
//
//  Created by 박진홍 on 12/11/24.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    private init() {}//모든 뷰컨에서 새롭게 선언하거나 주입할 필요 없이 접근할 수 있고 앱이 종료되는 시점까지도 사용될 가능성이 높은 객체라 싱글톤이 적합
    
    // MARK: PersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokeBook")//원하는 .xcdatamodeld파일의 이름
        container.loadPersistentStores { description, error in
            if let error = error {
                print("failed to load persistent container: \(error.localizedDescription)")//fatal error나 print처리는 개발 시에만 유용하고 배포 할 땐 반드시 적절한 에러처리를 따로 만들어야 함.
            }
        }
        return container
    }()
    
    // MARK: - Context
    var context: NSManagedObjectContext {//persistentContainer가 가진 viewContext를 쉽게 사용하기 위한 변수
        return persistentContainer.viewContext//PSC와 연결되어 데이터 작업이 가능하고 메인큐와 연관되어 메인 스레드에서 동작하는 객체를 연결해준다.
    }
    
    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("failed to save context: \(error.localizedDescription)") //이 부분도 전체적인 완성도를 높일 땐 에러 처리를 따로 해주어야 한다.
        }
    }
    
    // MARK: - Create
    func addContact(imageURL: String, name: String, phoneNumber: String ) {
        //NSEntityDescription.insertNewObject(forEntityName:, into:)를 사용하지 않고 자동 생성된 서브클래스를 이용하여 컨텍스트에 넣어주어 하드 코딩으로 인한 런타임 에러 발생 가능성을 컴파일타임에서 잡아낼 수 있도록 하고 유지보수성도 높이며 간결한 코드로 가독성 또한 증가됨.
        let contact = ContactData(context: context)//초기화 시 context를 주입하여 바로 사용가능해진다는 것을 나중에 돌아볼 때 기억하기 위해 남겨둔 코드
        contact.name = name
        contact.imageURL = imageURL
        contact.phoneNumber = phoneNumber
        
        saveContext()
    }
    //속성이 많아짐에 따라 좀 더 유연하게 확장 가능한 방법 중 하나인 빌더 패턴을 이용한 메서드
    func addContactByBuilder(builderBlock: (ContactDataBuilder) -> Void) {
        let builder = ContactDataBuilder(context: context)
        builderBlock(builder)
        saveContext()
    }
    
    // MARK: - Read
    func fetchContact() -> [ContactData] {//저장소에서 배열로 저장되어있는 데이터를 반환받는 메서드
        let fetchRequest: NSFetchRequest<ContactData> = ContactData.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("failed to fetch: \(error.localizedDescription)")
            return []//fetch 실패 시 빈 배열로 반환처리
        }
    }
    
    // MARK: - Update
    // add와 코드가 중복되지만 추가와 수정을 분리하는 것이 좀 더 장기적으로 나은 선택이라 생각하여 분리함.
    func updateContact(data: ContactData, builderBlock: (ContactDataBuilder) -> Void) {
        let builder = ContactDataBuilder(context: context, contactData: data)//수정할 기존 객체를 넣어줌
        builderBlock(builder)
    }
    
    // MARK: - Delete
    func deleteContact(data: ContactData) {
        context.delete(data)
        saveContext()
    }
}
