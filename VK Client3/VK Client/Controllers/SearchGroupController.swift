//
//  SearchGroupController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit

class SearchGroupController: UITableViewController, UISearchBarDelegate {
    
    var filteredGroups: [Group] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Actions
    
    @IBAction func addTapped(_ sender: UIButton) {
        
        guard
            let cell = sender.superview?.superview as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
        else { return }
        
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchGroupCell", for: indexPath) as! SearchGroupCell
        
        let group = filteredGroups[indexPath.row]
            
        cell.searchGroupNameLabel.text = group.name
        
        if let data = try? Data(contentsOf: group.photo) {
            cell.searchGroupImageView.image = UIImage(data: data)
        } else {
            cell.searchGroupImageView.image = UIImage(systemName: "person.fill")
        }
        
        return cell
    }
    
    // MARK: - Search Bar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        userService.searchByUserGroups(searchText: searchText.lowercased()) { [weak self] groups in
            self?.filteredGroups = groups
        }
        tableView.reloadData()
    }
    
    
    
}
