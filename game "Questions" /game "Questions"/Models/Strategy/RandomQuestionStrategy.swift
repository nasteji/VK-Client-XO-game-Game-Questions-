//
//  RandomQuestionStrategy.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 14.07.2021.
//

import Foundation

class RandomQuestionStrategy: QuestionStrategy {
    func fake() -> [Question] {
        let questions: [Question] = [.question1, .question2, .question3, .question4, .question5]
        var randomQuestions = [Question]()
        
        while randomQuestions.count != questions.count {
            let random = Int.random(in: 0...(questions.count - 1))
            if !randomQuestions.contains(questions[random]) {
                randomQuestions.append(questions[random])
            }
        }
        return randomQuestions
    }

}
