//
//  BlindGameState.swift
//  XO-game
//
//  Created by Анастасия Живаева on 12.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class BlindGameState: GameState {
    
    var isMoveCompleted: Bool = false
    var player: Player!
    weak var gameViewControler: BlindGameViewController?
    var gameBoard: Gameboard
    var gameBoardView: GameboardView
    var markViewPrototype: MarkView
    
    init(player: Player?, gameViewControler: BlindGameViewController,
         gameBoard: Gameboard,
         gameboardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewControler = gameViewControler
        self.gameBoard = gameBoard
        self.gameBoardView = gameboardView
        self.markViewPrototype = markViewPrototype
    }
    
    func addSign(at position: GameboardPosition) {
        guard !isMoveCompleted else { return }
        Logger.shared.log(playerPosition: PlayerPosition(player: player, position: position, gameBoard: gameBoard, gameBoardView: gameBoardView))
           
        gameViewControler?.gameboardView.placeMarkView(markViewPrototype, at: position)
        gameViewControler?.gameBoard.setPlayer(player, at: position)
        
        isMoveCompleted = true
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewControler?.firstPlayerTurnLabel.isHidden = false
            gameViewControler?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewControler?.firstPlayerTurnLabel.isHidden = true
            gameViewControler?.secondPlayerTurnLabel.isHidden = false
        case .none:
            break
        }

        gameViewControler?.winnerLabel.isHidden = true
    }
    
}
