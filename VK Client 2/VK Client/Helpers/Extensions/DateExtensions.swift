//
//  DateExtensions.swift
//  VK Client
//
//  Created by Анастасия Живаева on 27.05.2021.
//

import Foundation

extension Date {
    func unixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
    
