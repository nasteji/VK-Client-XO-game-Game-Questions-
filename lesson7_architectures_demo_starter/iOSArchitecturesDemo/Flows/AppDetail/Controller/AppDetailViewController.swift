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
    
//    override func loadView() {
//        super.loadView()
//        self.view = AppDetailView()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
//        self.configureNavigationController()
//        self.downloadImage()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        addHeaderViewController()
        addDescriptionViewController()
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
    
    private func addDescriptionViewController() {
        //ДЗ Добавить другие модули
        let descriptionVC = UIViewController()
        
        self.view.addSubview(descriptionVC.view)
        self.addChild(descriptionVC)
        descriptionVC.didMove(toParent: self)
        
        guard let descriptionView = descriptionVC.view else { return }
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            descriptionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            descriptionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
    }
    
//    private func configureNavigationController() {
//        self.navigationController?.navigationBar.tintColor = UIColor.white;
//        self.navigationItem.largeTitleDisplayMode = .never
//    }
//
//    private func downloadImage() {
//        guard let url = self.app?.iconUrl else { return }
//        self.appDetailView.throbber.startAnimating()
//        self.imageDownloader.getImage(fromUrl: url) { (image, error) in
//            self.appDetailView.throbber.stopAnimating()
//            guard let image = image else { return }
//            self.appDetailView.imageView.image = image
//        }
//    }
}
