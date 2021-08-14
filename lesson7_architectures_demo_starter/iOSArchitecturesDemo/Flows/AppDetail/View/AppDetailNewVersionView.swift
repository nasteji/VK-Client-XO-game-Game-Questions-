//
//  AppDetailNewVersionView.swift
//  iOSArchitecturesDemo
//
//  Created by Анастасия Живаева on 09.08.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailNewVersionView: UIView {
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 5
        
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.textAlignment = .right
        
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
        self.addSubview(titleLabel)
        self.addSubview(versionLabel)
        self.addSubview(textLabel)
        self.addSubview(dateLabel)
     
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            versionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            versionLabel.widthAnchor.constraint(equalToConstant: 100),
            
            textLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 20),
            textLabel.leftAnchor.constraint(equalTo: versionLabel.leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            
            dateLabel.topAnchor.constraint(equalTo: versionLabel.topAnchor),
            dateLabel.rightAnchor.constraint(equalTo: textLabel.rightAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
}
