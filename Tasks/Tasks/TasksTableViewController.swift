//
//  TasksTableViewController.swift
//  Tasks
//
//  Created by Анастасия Живаева on 27.07.2021.
//

import UIKit

class TasksTableViewController: UITableViewController {
    
    var tasks: [Task] = [] {
        didSet {
            countRows = tasks.count
        }
    }

    var toptask1 = Task(name: "купить", subTasks: [])
    
    var task1 = Task(name: "хлеб", subTasks: [])
    var task2 = Task(name: "молоко", subTasks: [])
    
    var subTask1 = Task(name: "черный", subTasks: [])
    var subTask2 = Task(name: "батон", subTasks: [])
    
    var countRows = 0
    
    @IBAction func addButton(_ sender: Any) {
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        task1.subTasks.append(contentsOf: [subTask1, subTask2])
        toptask1.subTasks.append(contentsOf: [task1, task2])
        tasks.append(toptask1)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.taskLabel.text = tasks[indexPath.row].name
        cell.numberOfSubtasks.text = String(tasks[indexPath.row].countSubTasks)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks = tasks[indexPath.row].subTasks
        tableView.reloadData()
    }
}
