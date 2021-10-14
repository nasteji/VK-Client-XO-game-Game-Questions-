//
//  Logger.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 19.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class Logger {
    public static var shared = Logger()

    private init() {}

    public func log(playerPosition: PlayerPosition) {
        let command = LogCommand(playerPosition: playerPosition)
        LogInvoker.shared.addLogCommand(command: command)
    }
}
