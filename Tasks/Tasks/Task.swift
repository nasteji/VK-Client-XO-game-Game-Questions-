//
//  Task.swift
//  Tasks
//
//  Created by Анастасия Живаева on 31.07.2021.
//

import Foundation

class Task {
    let name: String
    var subTasks: [Task] {
        didSet {
            countSubTasks = subTasks.count
        }
    }
    var countSubTasks: Int
    
    init(name: String, subTasks: [Task]) {
        self.name = name
        self.subTasks = subTasks
        self.countSubTasks = subTasks.count
    }
}
