//
//  Game.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 13.07.2021.
//

import Foundation

final class Game {

    static let shared = Game()
    
    private(set) var results: [Result] {
        didSet {
            resultsCareTaker.saveResults(results: results)
        }
    }
    
    private(set) var usersQuestions: [Question] {
        didSet {
            usersQuestionsCareTaker.saveQuestions(question: usersQuestions)
        }
    }

    private let resultsCareTaker = CareTaker()
    private let usersQuestionsCareTaker = CareTaker()
   
    var gameSession: GameSession?
    
    var queueQuestions: Bool = true
    
    internal init(results: [Result], usersQuestions: [Question]) {
        self.results = results
        self.usersQuestions = usersQuestions
    }
    
    private init() {
        results = resultsCareTaker.loadResults() ?? []
        usersQuestions = usersQuestionsCareTaker.loadQuestions() ?? []
    }
    
    func percentOfCorrectAnswers() -> String {
        if let session = gameSession {
            let result = (session.correctAnswers.value * 100) / session.questionsCount
            return "\(result) %"
        } else {
            return ""
        }
    }
    
    func addResult() {
        let result = Result(date: Date(), result: percentOfCorrectAnswers())
        results.insert(result, at: 0)
    }
    
    func clearResult() {
        results.removeAll()
    }
    
    func addQuestions(question: [Question]) {
        usersQuestions.append(contentsOf: question)
    }
    
    func clearQuestions() {
        usersQuestions.removeAll()
    }
    
}
