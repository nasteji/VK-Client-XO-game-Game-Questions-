//
//  DoubleExtensions.swift
//  VK Client
//
//  Created by Анастасия Живаева on 27.05.2021.
//

import Foundation

extension Double {
    func convertFromUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let dateInterval = Date(timeIntervalSince1970: self)
        return dateFormatter.string(from: dateInterval)
    }
}
    
