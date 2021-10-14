//
//  GameViewController.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 10.07.2021.
//

import UIKit

class GameViewController: UITableViewController {
    
    @IBOutlet weak var gameSesionLabel: UILabel!
    
    private var questionStrategy: QuestionStrategy {
        switch Game.shared.queueQuestions {
        case true:
            return LineQuestionStrategy()
        default:
            return RandomQuestionStrategy()
        }
    }
    
    var results: ((Date, String) -> Void)?

    var questions: [Question] = []
    let userQuestions = Game.shared.usersQuestions
    var count = 0
    var gameSession = GameSession()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = userQuestions + questionStrategy.fake()
        Game.shared.gameSession = gameSession
        gameSession.questionsCount = questions.count
        
        gameSession.correctAnswers.addObserver(self, options: [.initial, .new], closure: { [weak self] (correctAnswers, _) in
            guard let self = self else { return }
            
            self.gameSesionLabel.text = "Вопрос №\(self.count + 1). Правильных ответов: \(Game.shared.percentOfCorrectAnswers())"
        })
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .systemTeal
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = questions[count].question
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        (tableView.frame.height - gameSesionLabel.frame.height) / 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ((tableView.frame.height - gameSesionLabel.frame.height) / 2) / CGFloat(questions[count].answers.count + 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswersTableViewCell
        
        cell.answerLabel.text = questions[count].answers[indexPath.row]
        cell.numberLabel.text = String("\(indexPath.row + 1). ")
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! AnswersTableViewCell
        
        if cell.answerLabel.text == questions[count].correctAnswer, count < (questions.count - 1) {
            count += 1
            gameSession.correctAnswers.value += 1
            
            tableView.reloadData()
        } else {
            if cell.answerLabel.text == questions[count].correctAnswer, count == (questions.count - 1) {
                gameSession.correctAnswers.value += 1
            }
            results?(Date(), Game.shared.percentOfCorrectAnswers())
            Game.shared.addResult()
            Game.shared.gameSession = nil
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}
