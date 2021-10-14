//
//  LogReceiver.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 19.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class LogReceiver {
    func execute(playerPosition: PlayerPosition) {
        if playerPosition.gameBoardView.canPlaceMarkView(at: playerPosition.position) == false {
            playerPosition.gameBoardView.removeMarkView(at: playerPosition.position)
        }
        playerPosition.gameBoardView.placeMarkView(playerPosition.player.markViewPrototype, at: playerPosition.position)
        playerPosition.gameBoard.setPlayer(playerPosition.player, at: playerPosition.position)
    }
}
