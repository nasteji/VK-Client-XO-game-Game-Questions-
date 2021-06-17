//
//  AppError.swift
//  VK Client
//
//  Created by Анастасия Живаева on 17.06.2021.
//

import Foundation

enum AppError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectUrl
}
