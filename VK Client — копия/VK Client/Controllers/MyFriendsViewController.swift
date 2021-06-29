//
//  MyFriendsViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import SwiftUI

class MyFriendsViewController: UITableViewController {
    
    var myFriendsDictionary = Friend.fakeDictionary()
    var objectArray = [Objects]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (key, value) in myFriendsDictionary {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
            objectArray.sort(by: { $0.sectionName.lowercased() < $1.sectionName.lowercased() } )
        }
        
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseID)
        
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: CustomHeaderView.reuseID)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.reuseID) as? CustomHeaderView
        else { return nil }
        
        headerView.label.text = objectArray[section].sectionName
        headerView.color(color: tableView.backgroundColor!, opacity: 0.6)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CustomHeaderView.height
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(myFriendsDictionary.keys.sorted(by: { $0.lowercased() < $1.lowercased() }))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let friend = objectArray[indexPath.section].sectionObjects[indexPath.row]
        
        cell.nameLabel.text = friend.friendName
        
        if let image = friend.friendImage {
            cell.imageViewAvatar.image = UIImage(named: image)
        } else {
            cell.imageViewAvatar.image = UIImage(systemName: "person.fill")
        }
        
        return cell
    }

    // MARK: - Segues
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "SegueToFriendsFotoController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? FriendsFotoController,
           let indexPath = tableView.indexPathForSelectedRow {

            let friend = objectArray[indexPath.section].sectionObjects[indexPath.row]

            controller.friendName = friend.friendName
            controller.friendGallery = friend.friendGallery ?? ["фон"]
        }
    }
    
}


