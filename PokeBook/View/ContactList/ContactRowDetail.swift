//
//  ContactRowDetailView.swift
//  PokeBook
//
//  Created by 박진홍 on 12/9/24.
//
import UIKit

final class ContactRowDetail: UIStackView {
    //stack에 들어갈 뷰 인스턴스 생성
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        
        return image
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "temp"
        
        return label
    }()
    
    let number: UILabel = {
        let label = UILabel()
        label.text = "temp"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        //Stack 설정
        axis = .horizontal
        spacing = 10
        alignment = .center
        distribution = .fillProportionally
        
        //오토레이아웃 설정과 stack에 추가
        [profileImage, name, number].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
        
        //오토레이아웃 설정
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            name.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            name.heightAnchor.constraint(equalTo: profileImage.heightAnchor),
            
            number.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            number.heightAnchor.constraint(equalTo: profileImage.heightAnchor)
        ])
    }
}
