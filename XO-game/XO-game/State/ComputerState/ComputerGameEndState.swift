//
//  ComputerGameEndState.swift
//  XO-game
//
//  Created by Анастасия Живаева on 27.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class ComputerGameEndState: GameState {
    var isMoveCompleted: Bool = false
    
    public let winnerPlayer: Player?
    weak var gameViewControler: GameWithComputerViewController?
    
    init(winnerPlayer: Player?, gameViewControler: GameWithComputerViewController) {
        self.winnerPlayer = winnerPlayer
        self.gameViewControler = gameViewControler
    }
    
    func addSign(at position: GameboardPosition) {}
    
    func begin() {
        gameViewControler?.winnerLabel.isHidden = false
        
        if let winnerPlayer = winnerPlayer {
            gameViewControler?.winnerLabel.text = setPlayerName(player: winnerPlayer) + " won"
        } else {
            gameViewControler?.winnerLabel.text = "No winner/Draw"
        }
        
        gameViewControler?.firstPlayerTurnLabel.isHidden = true
        gameViewControler?.secondPlayerTurnLabel.isHidden = true
    }
    
    private func setPlayerName(player: Player) -> String {
        switch player {
        case .first:
            return "Player"
        case .second:
            return "Computer"
        }
    }
    
}
