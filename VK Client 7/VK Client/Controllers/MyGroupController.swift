//
//  MyGroupController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import RealmSwift

class MyGroupController: UITableViewController {
    
    var myGroups: [Group] = []
    
    var token = NotificationToken()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        userService.loadGroups() { [weak self] in
            self?.readData()
            self?.loadData()
        }
        
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseID)
    }
    
    // MARK: - Load and Read Data
    
    func loadData() {
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            self.myGroups = Array(groups.sorted(byKeyPath: "name"))
        } catch {
            print(error)
        }
    }
    
    func readData() {
        guard let realm = try? Realm() else { return }
        let groups = realm.objects(Group.self)
        token = groups.observe { changes in
            guard let tableView = self.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
                print("Start to modified Groups")
            case .update(let results, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                self.loadData()
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.endUpdates()
                print("Groups were modified: \(results)")
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.reuseID, for: indexPath) as! ListCell
        
        let group = myGroups[indexPath.row]
        cell.configure(group: group)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let group = myGroups[indexPath.row]
    
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(group)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Segues
    
    @IBAction func unwindFromSearchGroup(_ segue: UIStoryboardSegue) {
        guard let controller = segue.source as? SearchGroupController,
              let indexPath = controller.tableView.indexPathForSelectedRow
        else { return }

        let newGroup = controller.filteredGroups[indexPath.row]

        do {
            let realm = try Realm()
            if !realm.objects(Group.self).contains(newGroup) {
                realm.beginWrite()
                realm.add(newGroup)
                try realm.commitWrite()
            }
        } catch {
            print(error)
        }
    }
    
   
}
