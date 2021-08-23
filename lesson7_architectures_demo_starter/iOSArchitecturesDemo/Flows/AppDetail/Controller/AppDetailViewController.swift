//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    public var app: ITunesApp
    
    private let imageDownloader = ImageDownloader()
    
    lazy var headerDetailViewController = AppDetailHeaderViewController(app: app)
    lazy var newVersionDetailViewController = AppDetailNewVersionViewController(app: app)
    
    private var appDetailView: AppDetailView {
        return self.view as! AppDetailView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        addHeaderViewController()
        addNewVersionViewController()
    }
    
    private func addHeaderViewController() {
        self.view.addSubview(headerDetailViewController.view)
        self.addChild(headerDetailViewController)
        headerDetailViewController.didMove(toParent: self)
        
        guard let headerView = headerDetailViewController.view else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
    }
    
    private func addNewVersionViewController() {
        self.view.addSubview(newVersionDetailViewController.view)
        self.addChild(newVersionDetailViewController)
        newVersionDetailViewController.didMove(toParent: self)
        
        guard let newVersionView = newVersionDetailViewController.view else { return }
        newVersionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newVersionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 220),
            newVersionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            newVersionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
    }
    
}
