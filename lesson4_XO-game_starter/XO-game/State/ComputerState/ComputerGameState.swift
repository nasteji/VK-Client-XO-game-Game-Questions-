//
//  ComputerGameState.swift
//  XO-game
//
//  Created by Анастасия Живаева on 27.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class ComputerGameState: GameState {
    
    var isMoveCompleted: Bool = false
    var player: Player!
    weak var gameViewControler: GameWithComputerViewController?
    var gameBoard: Gameboard
    var gameBoardView: GameboardView
    var markViewPrototype: MarkView
    
    init(player: Player?, gameViewControler: GameWithComputerViewController,
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
        
        Logger.shared.log(action: .playerSetMarkView(player: player, position: position))
        switch player {
        case .first:
            gameViewControler?.gameboardView.placeMarkView(markViewPrototype, at: position)
            gameViewControler?.gameBoard.setPlayer(player, at: position)
        case .second:
            var randomPosition = GameboardPosition(column: 0, row: 0)
            
            while gameBoardView.canPlaceMarkView(at: randomPosition) == false {
                let column = Int.random(in: 0...2)
                let row = Int.random(in: 0...2)
                randomPosition = GameboardPosition(column: column, row: row)
            }
            gameViewControler?.gameboardView.placeMarkView(markViewPrototype, at: randomPosition)
            gameViewControler?.gameBoard.setPlayer(player, at: randomPosition)
        case .none:
            break
        }
        
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
