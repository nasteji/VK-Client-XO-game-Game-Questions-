//
//  LogInvoker.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 19.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class LogInvoker {
    public static let shared = LogInvoker()
    
    private let receiver = LogReceiver()
    private var commands: [LogCommand] = []
    private let bufferSize = 10
    
    private init() {}
    
    func addLogCommand(command: LogCommand) {
        commands.append(command)
    }
    
    func execute() {
        guard commands.count >= bufferSize else { return }
        var firstIndex = 0
        let halfBufferSize = bufferSize / 2
        
        while firstIndex <= (halfBufferSize - 1) {
            receiver.execute(playerPosition: commands[firstIndex].playerPosition)

            let lastIndex = firstIndex + halfBufferSize
            receiver.execute(playerPosition: commands[lastIndex].playerPosition)
         
            firstIndex += 1
        }
        commands = []
    }
}
