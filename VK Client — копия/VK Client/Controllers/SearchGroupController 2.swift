//
//  SearchGroupController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit

class SearchGroupController: UITableViewController, UISearchBarDelegate {
    
    var allGroups = Group.fakeAll()
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

        filteredGroups = allGroups
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchGroupCell", for: indexPath) as! SearchGroupCell
        
        let group = filteredGroups[indexPath.row]
            
        cell.searchGroupNameLabel.text = group.groupName
        if let image = group.groupImage {
            cell.searchGroupImageView.image = UIImage(named: image)
        } else {
            cell.searchGroupImageView.image = UIImage(systemName: "person.3.fill")
        }
        
        return cell
    }
    
    // MARK: - Search Bar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredGroups = searchText.isEmpty ? allGroups : allGroups.filter({ $0.groupName.lowercased().contains(searchText.lowercased()) })
       
        tableView.reloadData()
    }
    
    
    
}
