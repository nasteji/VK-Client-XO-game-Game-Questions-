//
//  AddQuestionsTableViewController.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 17.07.2021.
//

import UIKit

class AddQuestionsTableViewController: UITableViewController {
    
    @IBAction func saveQuestionsButton(_ sender: Any) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionsTableViewCell") as! AddQuestionsTableViewCell
        
        if !self.newQuestions.contains(cell.newQuestion) {
            self.newQuestions.append(cell.newQuestion)
        }
        
        Game.shared.addQuestions(question: newQuestions)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addQuestionsButton(_ sender: Any) {
        countQuestions += 1
        tableView.reloadData()
    }
    
    var countQuestions = 1
    var newQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "AddQuestionsTableViewCell", bundle: nil), forCellReuseIdentifier: AddQuestionsTableViewCell.reuseId)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countQuestions
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionsTableViewCell", for: indexPath) as! AddQuestionsTableViewCell
        
        cell.config()
        return cell
    }
    

    
}
