//
//  AppDetailNewVersionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Анастасия Живаева on 09.08.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailNewVersionViewController: UIViewController {
    private let app: ITunesApp
    private let imageDownloader = ImageDownloader()
    private var appDetailNewVersionView: AppDetailNewVersionView {
        return self.view as! AppDetailNewVersionView
    }
    
    private let dateFormatter: ISO8601DateFormatter = {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
        ]
        return isoDateFormatter
    }()
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailNewVersionView()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        appDetailNewVersionView.titleLabel.text = "Что нового"
        if let version = app.version {
            appDetailNewVersionView.versionLabel.text = "Версия \(version)"
        }
        if let date = app.currentVersionReleaseDate,
           let correctDate = dateFormatter.date(from: date) {
            appDetailNewVersionView.dateLabel.text = "от \(correctDate)"
        }
        appDetailNewVersionView.textLabel.text = app.releaseNotes
    }
    
}
