//
//  LineQuestionStrategy.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 14.07.2021.
//

import Foundation

class LineQuestionStrategy: QuestionStrategy {
    func fake() -> [Question] {
        [.question1, .question2, .question3, .question4, .question5]
    }
    
}
