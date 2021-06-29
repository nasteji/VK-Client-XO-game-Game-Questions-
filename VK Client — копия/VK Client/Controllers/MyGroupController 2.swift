//
//  MyGroupController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit

class MyGroupController: UITableViewController {
    
    var myGroups = Group.fakeFavorite()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseID)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let group = myGroups[indexPath.row]
        
        cell.nameLabel.text = group.groupName
        
        if let image = group.groupImage {
            cell.imageViewAvatar.image = UIImage(named: image)
        } else {
            cell.imageViewAvatar.image = UIImage(systemName: "person.3.fill")
        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Segues
    
    @IBAction func unwindFromSearchGroup(_ segue: UIStoryboardSegue) {
        guard let controller = segue.source as? SearchGroupController,
              let indexPath = controller.tableView.indexPathForSelectedRow
        else { return }
        
        let newGroup = controller.filteredGroups[indexPath.row]
        
        if !myGroups.contains(newGroup) {
            myGroups.append(newGroup)
            tableView.reloadData()
        }
    }
   
}
