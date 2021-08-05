//
//  MyFriendsViewController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import SwiftUI
import RealmSwift

class MyFriendsViewController: UITableViewController {
    
    private let userService = FriendAdapter()
    
    private var usersDictionary = [String: [Friend]]()
    private var objectArray = [Objects]()
    
    private let viewModelFactory = ListViewModelFactory()
    private var viewModels: [ListViewModel] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.getFriends { [weak self] user in
            guard let self = self else { return }
            self.usersDictionary = Friend.dictionary(users: user)
            for (key, value) in self.usersDictionary {
                   self.objectArray.append(Objects(sectionName: key, sectionObjects: value))
                   self.objectArray.sort(by: { $0.sectionName.lowercased() < $1.sectionName.lowercased() } )
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
        return Array(usersDictionary.keys.sorted(by: { $0.lowercased() < $1.lowercased() }))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        self.viewModels = self.viewModelFactory.constructUserViewModels(from: objectArray[indexPath.section].sectionObjects as! [Friend])
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }

    // MARK: - Segues
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "SegueToFriendsFotoController", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let controller = segue.destination as? FriendsFotoController,
           let indexPath = tableView.indexPathForSelectedRow {

            let user = objectArray[indexPath.section].sectionObjects[indexPath.row] as! Friend

            controller.friendName = user.firstName + " " + user.lastName
            controller.id = user.id
        }
    }
    
}


