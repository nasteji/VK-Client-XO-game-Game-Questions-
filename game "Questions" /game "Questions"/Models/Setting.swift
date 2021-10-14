//
//  Setting.swift
//  game "Questions"
//
//  Created by Анастасия Живаева on 14.07.2021.
//

import Foundation

struct Setting {
    
    var settingName : String
    var settingValue : [String]
}

extension Setting {
    static var setting1 = Setting(settingName: "Последовательность вопросов", settingValue: ["По порядку", "Перемешать"])
    
    static func fake() -> [Setting] {
        return [.setting1]
    }
}
