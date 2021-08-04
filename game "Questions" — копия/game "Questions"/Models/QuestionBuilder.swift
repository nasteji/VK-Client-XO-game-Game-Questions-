//
//  QuestionBuilder.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 18.07.2021.
//

import Foundation

class QuestionBuilder {
    
    public static var shared = QuestionBuilder()
    
    private init() {}
    
    private(set) var question: String = ""
    private(set) var answers: [String] = []
    private(set) var correctAnswer: String = ""
    
    func build() -> Question {
        return Question(question: question, answers: answers, correctAnswer: correctAnswer)
    }
    
    func setQuestion(_ question: String) {
        self.question = question
    }
    
    func setAnswers(_ answers: [String]) {
        self.answers = answers
    }
    
    func setCorrectAnswer(_ correctAnswer: String) {
        self.correctAnswer = correctAnswer
    }
   
}
