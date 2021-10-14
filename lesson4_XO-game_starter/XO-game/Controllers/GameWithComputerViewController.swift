//
//  GameWithComputerViewController.swift
//  XO-game
//
//  Created by Анастасия Живаева on 27.07.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class GameWithComputerViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private var counter: Int = 0
    public let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    var position: GameboardPosition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlayerTurn()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.position = position
            self.currentState.addSign(at: position)
            self.counter += 1
            if self.currentState.isMoveCompleted {
                self.nextPlayerTurn()
            }
        
        }
    }
    
    private func firstPlayerTurn() {
        winner()
        
        let firstPlayer: Player = .first
        currentState = ComputerGameState(player: firstPlayer,
                                         gameViewControler: self,
                                         gameBoard: gameBoard,
                                         gameboardView: gameboardView,
                                         markViewPrototype: firstPlayer.markViewPrototype)
    }
    
    private func nextPlayerTurn() {
        winner()
        
        if counter >= 9 {
            currentState = ComputerGameEndState(winnerPlayer: nil, gameViewControler: self)
            return
        }
        
        if let playerState = currentState as? ComputerGameState{
            self.counter += 1
            let nextPlayer = playerState.player.next
            currentState = ComputerGameState(player: nextPlayer,
                                             gameViewControler: self,
                                             gameBoard: gameBoard,
                                             gameboardView: gameboardView,
                                             markViewPrototype: nextPlayer.markViewPrototype)
            currentState.addSign(at: position ?? GameboardPosition(column: 0, row: 0))
            self.firstPlayerTurn()
        }
    }
    
    private func winner() {
        if let winner = referee.determineWinner() {
            currentState = ComputerGameEndState(winnerPlayer: winner, gameViewControler: self)
        }
    }
        
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.clear()
        gameBoard.clear()
        counter = 0
        
        firstPlayerTurn()
        
    }


}
