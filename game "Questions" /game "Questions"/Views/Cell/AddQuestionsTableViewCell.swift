//
//  AddQuestionsTableViewCell.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 18.07.2021.
//

import UIKit

class AddQuestionsTableViewCell: UITableViewCell, SendActionDelegate {
    
    weak var delegate: NewQuestionDelegate?
    
    static let reuseId = "AddQuestionsTableViewCell"
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswersTextField: UITextField!
    @IBOutlet weak var answers1TextField: UITextField!
    @IBOutlet weak var answers2TextField: UITextField!
    @IBOutlet weak var answers3TextField: UITextField!
    
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
    
    func sendMessage() {
        if let question = questionTextField.text,
           let answer1 = answers1TextField.text,
           let answer2 = answers2TextField.text,
           let answer3 = answers3TextField.text,
           let correctAnswer = correctAnswersTextField.text {
            delegate?.addQuestion(question: question, correctAnswer: correctAnswer, answer1: answer1, answer2: answer2, answer3: answer3)
        }
    }
    
}
