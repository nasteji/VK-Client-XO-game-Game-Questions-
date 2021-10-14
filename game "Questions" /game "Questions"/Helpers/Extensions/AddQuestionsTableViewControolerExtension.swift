//
//  AddQuestionsTableViewControolerExtension.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 04.08.2021.
//

import Foundation

extension AddQuestionsTableViewController: NewQuestionDelegate {
    func addQuestion(question: String, correctAnswer: String, answer1: String, answer2: String, answer3: String) {
        let builder = QuestionBuilder.shared
        builder.setAnswers([answer1, answer2, answer3, correctAnswer])
        builder.setQuestion(question)
        builder.setCorrectAnswer(correctAnswer)
        
        questionModel = builder.build()
        
        if !self.newQuestions.contains(questionModel) {
            self.newQuestions.append(questionModel)
        }

        Game.shared.addQuestions(question: newQuestions)
        print(Game.shared.usersQuestions.count)
    }
}
