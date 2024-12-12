//
//  DetailViewContoller.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//

import UIKit
import CoreData

protocol DetailViewControllerDelegate: AnyObject {
    func didSaveContact()
}

final class DetailViewController: UIViewController {
    weak var delegate: DetailViewControllerDelegate?
    private let detailView: DetailView = DetailView()
    private let networkManager: NetworkManager = NetworkManager.shared
    private let coreDataStack: CoreDataStack = CoreDataStack.shared // 싱글톤 객체에 접근
    private var currentImageURL: String = ""
    
    var contactID: NSManagedObjectID? //데이터 저장 시 설정하여 이후 로드나 수정 등에 활용할 수 있음. 아직 저장되지 않았거나 초기화 되지 않은 객체의 경우를 고려하여 옵셔널 처리
    
    override func loadView() {
        view = detailView//루트뷰를 detailView로 설정하기 위해 시점을 loadView로 설정함
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contactID = contactID {
            loadContactData(contactID: contactID)
        } else {
            prepareForNewContact()
        }
        setupButtonAction()
        setupNavigationBar()
    }
    // MARK: - setupNavigation
    private func setupNavigationBar() {
        if let contact = getContact(contactID: contactID) {
            navigationItem.title = contact.name
        } else {
            navigationItem.title = "New Pokemon"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: contactID == nil ? "Add" : "Edit", style: .plain, target: self, action: #selector(saveContact))
    }
    //MARK: - saveContact
    @objc private func saveContact() {
        if let contactID = contactID {
            updateExistingContact(contactID: contactID)
        } else {
            saveNewContact()
        }
        
        delegate?.didSaveContact() // 저장 후 델리게이트 호출
        navigationController?.popViewController(animated: true) // 테이블 뷰로 돌아감
    }
    
    private func saveNewContact() {
        coreDataStack.addContactByBuilder { builder in
            builder.setName(to: detailView.nameTextField.text ?? "")
                .setPhonenumber(to: detailView.phoneNumberTextField.text ?? "")
                .setImageURL(to: currentImageURL)
        }
    }
    
    private func updateExistingContact(contactID: NSManagedObjectID) {
        guard let contact = getContact(contactID: contactID) else { return }
        coreDataStack.updateContact(data: contact) { builder in
            builder.setName(to: detailView.nameTextField.text ?? "")
                .setPhonenumber(to: detailView.phoneNumberTextField.text ?? "")
        }
    }
    // MARK: - loadContactData
    private func loadContactData(contactID: NSManagedObjectID) {
        guard let contact = getContact(contactID: contactID) else { return }
        populateData(contact: contact) // 데이터 바인딩
    }
    
    private func populateData(contact: ContactData) {
        detailView.nameTextField.text = contact.name
        detailView.phoneNumberTextField.text = contact.phoneNumber
        if let imageURL = contact.imageURL {
            detailView.imageView.setImage(url: imageURL) // 이미지 로드
        } else {
            detailView.imageView.image = UIImage(systemName: "person.circle")
        }
    }
    
    // MARK: - setupButton
    //포켓몬 사진을 랜덤으로 가져오는 메서드
    private func fetchPokemonSprites() {
        networkManager.fetchPokemonSprites { [weak self] imageURL in
            guard let self = self, let imageURL = imageURL else { return }
            DispatchQueue.main.async {//
                self.detailView.imageView.setImage(url: imageURL)//ContactDetail/ImageView+Extension에 정의해둔 url을 바탕으로 이미지 설정하는 메서드
                self.currentImageURL = imageURL
            }
        }
    }
    
    //최종적으로 클로저 정의
    private func setupButtonAction() {
        detailView.randomPokemonButtonAction = { [weak self] in
            guard let self = self else { return }
            self.fetchPokemonSprites()
        }
    }
    
    // MARK: - get contact with id
    private func getContact(contactID: NSManagedObjectID?) -> ContactData? {
        guard let contactID = contactID else { return nil }
        do {
            guard let contact = try coreDataStack.context.existingObject(with: contactID) as? ContactData else {
                return nil
            }
            return contact
        } catch {
            print("Failed to load contact: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - isNewContact
    private func prepareForNewContact() {
        // 새 연락처 추가를 위해 초기 설정
        detailView.nameTextField.text = ""
        detailView.phoneNumberTextField.text = ""
        detailView.imageView.image = UIImage(systemName: "person.circle")
    }
}

#Preview{
    DetailViewController()
}
