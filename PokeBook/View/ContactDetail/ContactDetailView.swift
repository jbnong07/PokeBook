//
//  ContactDetailView.swift
//  PokeBook
//
//  Created by 박진홍 on 12/12/24.
//

import UIKit

final class DetailView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter name"
        return textField
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter phone number"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    let randomPokemonButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Pokemon", for: .normal)
        return button
    }()
    
    var randomPokemonButtonAction: (() -> Void)? //클로저 콜백
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupRandomPokemonButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .white
        let views: [UIView] = [imageView, nameTextField, phoneNumberTextField, randomPokemonButton]//TextField가 들어가면서 자동으로 UIView로 추론할 수 없게 되어 명시적으로 UIView배열을 만듬.
        
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 44),
            
            randomPokemonButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16),
            randomPokemonButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupRandomPokemonButtonAction() {
        randomPokemonButton.addAction(UIAction { [weak self] _ in//addTarget 대신 ios14 이상부터 지원하는 addAction 사용 @objc 메서드 없이 바로 클로저 기반으로 처리 가능!
            guard let self = self else { return }
            self.randomPokemonButtonAction?()
        }, for: .touchUpInside)
    }
}
