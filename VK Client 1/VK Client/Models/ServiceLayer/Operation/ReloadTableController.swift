//
//  ReloadTableController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 13.06.2021.
//

import Foundation

class ReloadTableController: Operation {
    
    var controller: RealmController
    
    init(controller: RealmController) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? DataParseOperation
        else {
            print("Data not parsed")
            return
        }
        controller.saveGroupsData(groups: parseData.outputData)
        controller.loadData()
        controller.readData()
        controller.tableView.reloadData()
    }
    
}
