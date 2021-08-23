//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Анастасия Живаева on 23.08.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchInteractorInput {
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

class SearchInteractor: SearchInteractorInput {
    private let searchService = ITunesSearchService()
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        searchService.getApps(forQuery: query, then: completion)
    }
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        searchService.getSongs(forQuery: query, completion: completion)
    }
}
