//
//  QuestionBuilder.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 18.07.2021.
//

import Foundation

class QuestionBuilder {
    
    private(set) var question: String = ""
    private(set) var answers: [String] = []
    private(set) var correctAnswer: String = ""
    
    func build() -> Question {
        return Question(question: question, answers: answers, correctAnswer: correctAnswer)
    }
    
    func setQuestion(_ question: String) {
        self.question = question
    }
    
    func setAnswers(_ answer: String) {
        //if !self.answers.contains(answer) {
            answers.append(answer)
        //}
    }
    
    func setCorrectAnswer(_ correctAnswer: String) {
        self.correctAnswer = correctAnswer
    }
   
}
