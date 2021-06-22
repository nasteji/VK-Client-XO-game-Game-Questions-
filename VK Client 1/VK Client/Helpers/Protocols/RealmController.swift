//
//  RealmController.swift
//  VK Client
//
//  Created by Анастасия Живаева on 13.06.2021.
//

import Foundation
import UIKit

protocol RealmController: UITableViewController {
    
    func saveGroupsData(groups: [Group])
    func loadData()
    func readData()
    
}
