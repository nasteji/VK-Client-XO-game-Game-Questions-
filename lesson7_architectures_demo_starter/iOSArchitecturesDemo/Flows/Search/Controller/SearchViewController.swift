//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: SearchViewOutput
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    private var searchViewFlag = true
    
    private let searchService = ITunesSearchService()
    var searchResults = [ITunesApp]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    var searchResultsSong = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    private struct Constants {
        static let reuseIdentifierAppCell = "reuseIdApp"
        static let reuseIdentifierSongCell = "reuseIdSong"
    }
    
    // MARK: - Lifecycle
    
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        searchView.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifierAppCell)
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseIdentifierSongCell)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
    
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchViewFlag == true {
            return searchResults.count
        } else {
            return searchResultsSong.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierAppCell, for: indexPath)
        if searchViewFlag == true {
            guard let cell = dequeuedCell as? AppCell else {
                return dequeuedCell
            }
            let app = self.searchResults[indexPath.row]
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell.configure(with: cellModel)
            return cell
        } else {
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierSongCell, for: indexPath)
            guard let cell = dequeuedCell as? SongCell else {
                return dequeuedCell
            }
            let song = self.searchResultsSong[indexPath.row]
            let cellModel = SongCellModelFactory.cellModel(from: song)
            cell.configure(with: cellModel)
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchViewFlag == true {
            let app = searchResults[indexPath.row]
            let appDetaillViewController = AppDetailViewController(app: app)
            appDetaillViewController.app = app
            presenter.viewDidSelectApp(app: app)
        } else {
            return
        }
        
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        
        if searchViewFlag == true {
            presenter.viewDidSearch(with: query)
        } else {
            presenter.viewDidSearchSong(with: query)
        }
        
    }
}

extension SearchViewController: SearchViewInput {
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}

extension SearchViewController: SearchViewDelegate {
    func controlTapped() {
        searchView.tableView.isHidden = false
        searchViewFlag.toggle()
        searchView.tableView.reloadData()
    }
    
    
}
