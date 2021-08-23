//
//  AppDetailHeaderView.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 29.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderView: UIView {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var openButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Открыть", for: .normal)
        button.backgroundColor = UIColor(white: 0.3, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        return button
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(openButton)
        self.addSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            subTitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subTitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            openButton.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16),
            openButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            openButton.widthAnchor.constraint(equalToConstant: 80),
            openButton.heightAnchor.constraint(equalToConstant: 32),
            
            ratingLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            ratingLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 100),
            ratingLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
    
    
}
