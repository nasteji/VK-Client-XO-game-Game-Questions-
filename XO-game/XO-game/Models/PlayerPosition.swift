//
//  PlayerPosition.swift
//  XO-game
//
//  Created by Анастасия Живаева on 16.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerPosition {
    let player: Player
    let position: GameboardPosition
    let gameBoard: Gameboard
    let gameBoardView: GameboardView
    
    init(player: Player, position: GameboardPosition, gameBoard: Gameboard, gameBoardView: GameboardView) {
        self.player = player
        self.position = position
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
    }
}
