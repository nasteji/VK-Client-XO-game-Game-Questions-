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
    
    let interactor: SearchInteractorInput
    let router: SearchRouterInput
    
    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func openDetails(with app: ITunesApp) {
        router.openDetails(for: app)
    }
}

extension SearchPresenter: SearchViewOutput {
    
    func viewDidSearchSong(with query: String) {
        viewInput?.throbber(show: true)
        
        interactor.requestSongs(with: query) { [weak self] result in
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
    
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        
        interactor.requestApps(with: query) { [weak self] (result) in
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
    
    func viewDidSelectApp(app: ITunesApp) {
        openDetails(with: app)
    }
    
    
}
