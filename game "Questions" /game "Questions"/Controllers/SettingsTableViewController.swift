//
//  SettingsTableViewController.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 14.07.2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let settings = Setting.fake()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].settingName
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].settingValue.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        
        cell.settingLabel.text = settings[indexPath.section].settingValue[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SettingsTableViewCell
        
        switch cell.settingLabel.text {
        case settings[indexPath.section].settingValue[0]:
            Game.shared.queueQuestions = true
            dismiss(animated: true, completion: nil)
        case settings[indexPath.section].settingValue[1]:
            Game.shared.queueQuestions = false
            dismiss(animated: true, completion: nil)
        default:
            break
        }
        
    }

}
