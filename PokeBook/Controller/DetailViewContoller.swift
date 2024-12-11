//
//  DetailViewContoller.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    private let detailView: DetailView = DetailView()
    private let networkManager: NetworkManager = NetworkManager()
    private let coreDataStack: CoreDataStack = CoreDataStack.shared // 싱글톤 객체에 접근
    
    var contactID: NSManagedObjectID? //데이터 저장 시 설정하여 이후 로드나 수정 등에 활용할 수 있음. 아직 저장되지 않았거나 초기화 되지 않은 객체의 경우를 고려하여 옵셔널 처리
    
    override func loadView() {
        view = detailView//루트뷰를 detailView로 설정하기 위해 시점을 loadView로 설정함
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
