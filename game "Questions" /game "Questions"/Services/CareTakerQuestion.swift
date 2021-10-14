//
//  CareTakerQuestion.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 04.08.2021.
//

import Foundation

class CareTakerQuestion {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "keyQuestion"
    
    func saveQuestions(questions: [Question]) {
        do {
            let data = try encoder.encode(questions)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestions() -> [Question]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
