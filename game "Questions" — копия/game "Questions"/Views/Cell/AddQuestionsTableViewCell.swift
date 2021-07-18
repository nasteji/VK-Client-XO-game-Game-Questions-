//
//  AddQuestionsTableViewCell.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 18.07.2021.
//

import UIKit

class AddQuestionsTableViewCell: UITableViewCell {
    
    static let reuseId = "AddQuestionsTableViewCell"
    
    let build = QuestionBuilder()
    
    var newQuestion = Question(question: "", answers: [], correctAnswer: "")
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswersTextField: UITextField!
    @IBOutlet weak var answers1TextField: UITextField!
    @IBOutlet weak var answers2TextField: UITextField!
    @IBOutlet weak var answers3TextField: UITextField!
    
    @IBAction func questionEditingDidEnd(_ sender: Any) {
        if let question = questionTextField.text {
            build.setQuestion(question)
        }
    }
    @IBAction func correctAnswerDidEnd(_ sender: Any) {
        if let correctAnswer = correctAnswersTextField.text {
            build.setCorrectAnswer(correctAnswer)
            build.setAnswers(correctAnswer)
        }
    }
    @IBAction func answer1DidEnd(_ sender: Any) {
        if let answer1 = answers1TextField.text {
            build.setAnswers(answer1)
        }
    }
    @IBAction func answer2DidEnd(_ sender: Any) {
        if let answer2 = answers2TextField.text {
            build.setAnswers(answer2)
        }
    }
    @IBAction func answer3DidEnd(_ sender: Any) {
        if let answer3 = answers3TextField.text {
            build.setAnswers(answer3)
            newQuestion = build.build()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config() {
        questionTextField.placeholder = "Введи свой вопрос"
        correctAnswersTextField.placeholder = "Правильный ответ"
        answers1TextField.placeholder = "Вариант ответа"
        answers2TextField.placeholder = "Вариант ответа"
        answers3TextField.placeholder = "Вариант ответа"
    }
    
}
