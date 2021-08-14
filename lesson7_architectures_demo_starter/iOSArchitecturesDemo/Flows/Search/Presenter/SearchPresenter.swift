//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 29.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: AnyObject {
    var searchResults: [ITunesApp] { get set }
    var searchResultsSong: [ITunesSong] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(app: ITunesApp)
    func viewDidSearchSong(with query: String)
}

class SearchPresenter {
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    private let searchService = ITunesSearchService()
    
    private func requestApp(with query: String) {
        searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.viewInput?.searchResults = []
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResults = apps
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func requestSong(with query: String) {
        searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            result
                .withValue { song in
                    guard !song.isEmpty else {
                        self.viewInput?.searchResultsSong = []
                        self.viewInput?.showNoResults()
                        return
                    }
                    self.viewInput?.hideNoResults()
                    self.viewInput?.searchResultsSong = song
                }
                .withError {
                    self.viewInput?.showError(error: $0)
                }
        }
    }
    
    private func openDetails(with app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearchSong(with query: String) {
        viewInput?.throbber(show: true)
        requestSong(with: query)
    }
    
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestApp(with: query)
    }
    
    func viewDidSelectApp(app: ITunesApp) {
        openDetails(with: app)
    }
    
    
}
