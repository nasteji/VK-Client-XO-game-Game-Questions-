//
//  MyGroupController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 26.02.2021.
//

import UIKit
import RealmSwift
import FirebaseFirestore
import Alamofire

class MyGroupController: UITableViewController, RealmController {
    
    var myGroups: [Group] = []
    
    var token = NotificationToken()
    
    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.name = "com.AsyncOperation.MyGroupController"
        operationQueue.qualityOfService = .utility
        return operationQueue
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.vk.com/method/groups.get"
        let parameters: Parameters = [
            "user_ids": user.userId,
            "access_token": user.token,
            "extended": 1,
            "v": "5.21"
        ]
        
        let request =  Alamofire.request(url, method: .get, parameters: parameters)
        let getData = GetDataOperation(request: request)
        let parseData = DataParseOperation()
        let reloadTableController = ReloadTableController(controller: self)
        
        parseData.addDependency(getData)
        reloadTableController.addDependency(parseData)
        
        operationQueue.addOperation(getData)
        operationQueue.addOperation(parseData)
        OperationQueue.main.addOperation(reloadTableController)
        
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: ListCell.reuseID)
    }
    
    // MARK: - Save Groups Data
    
    func saveGroupsData(groups: [Group]) {
        do {
            let realm = try Realm()
            
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)

            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
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
    
    // MARK: - Save To Firestore
    
    private func saveToFirestore(_ groups: [Group]) {
        
        let database = Firestore.firestore()

        let groupsToSend = groups
            .map { $0.toFirestore() }
            .reduce([:]) { $0.merging($1) { (current, _) in current } }
        
        database.collection("groups").document(user.userId).setData(groupsToSend, merge: true) { error in
            
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("data saved")
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
                
                saveToFirestore([newGroup])
            }
        } catch {
            print(error)
        }
    }
    
   
}
