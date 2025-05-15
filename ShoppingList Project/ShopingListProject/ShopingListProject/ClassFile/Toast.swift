//
//  Toast.swift
//  ShopingListProject
//
//  Created by mac on 01/07/24.
//

import UIKit

class CustomToast: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(image: UIImage?, message: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        self.imageView.image = image
        self.textLabel.text = message
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    func show(on view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
                    self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    self.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
                    self.widthAnchor.constraint(equalToConstant: view.frame.width - 80),
                    self.heightAnchor.constraint(equalToConstant: 40)
                ])
    }
    
    func hide() {
        removeFromSuperview()
    }
}
