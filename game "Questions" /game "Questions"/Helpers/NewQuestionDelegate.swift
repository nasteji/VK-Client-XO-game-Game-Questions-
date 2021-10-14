//
//  NewQuestionDelegate.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 04.08.2021.
//

import Foundation

protocol NewQuestionDelegate: AnyObject {
    func addQuestion(question: String, correctAnswer: String, answer1: String, answer2: String, answer3: String)
}
