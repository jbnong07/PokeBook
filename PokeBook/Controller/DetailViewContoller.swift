//
//  DetailViewContoller.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {
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
    
    //포켓몬 사진 가져오는 메서드
    private func fetchPokemonSprites() {
        networkManager.fetchPokemonSprites { [weak self] imageURL in
            guard let self = self, let imageURL = imageURL else { return }
            DispatchQueue.main.async {//
                self.detailView.imageView.setImage(url: imageURL)//ContactDetail/ImageView+Extension에 정의해둔 url을 바탕으로 이미지 설정하는 메서드
                self.updateContactImageURL(url: imageURL)
            }
        }
    }
    //contactID에 해당하는 객체를 빌더에 전달하여 url 업데이트
    private func updateContactImageURL(url: String) {
        guard let contactID = contactID else { return }
        do {
            guard let contact = try coreDataStack.context.existingObject(with: contactID) as? ContactData else { return }
            coreDataStack.updateContact(data: contact) { builder in
                builder.setImageURL(to: url)
            }
        } catch {
            print("Failed to update url: \(error.localizedDescription)")
        }
    }
    
    //최종적으로 클로저 정의
    private func setupButtonAction() {
        detailView.randomPokemonButtonAction = { [weak self] in
            guard let self = self else { return }
            self.fetchPokemonSprites()
        }
    }
}
