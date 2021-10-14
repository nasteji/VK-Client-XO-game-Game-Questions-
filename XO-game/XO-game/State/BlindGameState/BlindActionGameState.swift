//
//  BlindActionGameState.swift
//  XO-game
//
//  Created by Анастасия Живаева on 16.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class BlindActionGameState: GameState {
    
    var isMoveCompleted: Bool = false
    weak var gameViewControler: BlindGameViewController?
    var gameBoard: Gameboard
    var gameBoardView: GameboardView
    
    init(gameViewControler: BlindGameViewController,
         gameBoard: Gameboard,
         gameboardView: GameboardView) {
        self.gameViewControler = gameViewControler
        self.gameBoard = gameBoard
        self.gameBoardView = gameboardView
    }
    
    func addSign(at position: GameboardPosition) {
        guard !isMoveCompleted else { return }
        LogInvoker.shared.execute()
    }
    
    func begin() {
        gameViewControler?.secondPlayerTurnLabel.isHidden = true
        gameViewControler?.firstPlayerTurnLabel.isHidden = true
        gameViewControler?.winnerLabel.isHidden = true
    }
    
}
