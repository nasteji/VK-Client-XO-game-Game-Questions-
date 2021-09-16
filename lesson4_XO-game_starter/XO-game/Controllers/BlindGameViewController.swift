//
//  BlindGameViewController.swift
//  XO-game
//
//  Created by Анастасия Живаева on 12.09.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class BlindGameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private var counter: Int = 0
    private var maxCounter: Int {
        return (GameboardSize.columns * GameboardSize.rows) + 1
    }
    public let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlayerTurn()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addSign(at: position)
            self.counter += 1
            
            switch self.counter {
            case 0..<(self.maxCounter / 2):
                self.firstPlayerTurn()
            case (self.maxCounter / 2):
                self.clear()
                fallthrough
            case (self.maxCounter / 2)..<self.maxCounter:
                self.nextPlayerTurn()
            case self.maxCounter:
                self.clear()
                self.actionGame()
                self.currentState.addSign(at: position)
                self.winner()
            default:
                break
            }
        }
    }
    
    private func firstPlayerTurn() {
        let firstPlayer: Player = .first
        currentState = BlindGameState(player: firstPlayer,
                                     gameViewControler: self,
                                     gameBoard: gameBoard,
                                     gameboardView: gameboardView,
                                     markViewPrototype: firstPlayer.markViewPrototype)
        
    }
    
    private func nextPlayerTurn() {
        let secondPlayer: Player = .second
        currentState = BlindGameState(player: secondPlayer,
                                     gameViewControler: self,
                                     gameBoard: gameBoard,
                                     gameboardView: gameboardView,
                                     markViewPrototype: secondPlayer.markViewPrototype)
    }
    
    private func actionGame () {
        currentState = BlindActionGameState(gameViewControler: self,
                                         gameBoard: gameBoard,
                                         gameboardView: gameboardView)
    }
    
    private func winner() {
        if let winner = referee.determineWinner() {
            currentState = BlindGameEndState(winnerPlayer: winner, gameViewControler: self)
        } else {
            currentState = BlindGameEndState(winnerPlayer: nil, gameViewControler: self)
        }
    }
    
    private func clear() {
        gameboardView.clear()
        gameBoard.clear()
    }
        
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.clear()
        gameBoard.clear()
        counter = 0
        
        firstPlayerTurn()
    }




}
