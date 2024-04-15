//
//  Game.swift
//  RightOnTheTarget
//
//  Created by Denis Dareuskiy on 15.01.24.
//

import Foundation

protocol GameProtocol {
    associatedtype SecretType
    // Количество заработанных очков
    var score: Int { get }
    // Загаданное значение
    var secretValue: SecretType { get }
    // Проверяет, закончена ли игра
    var isGameEnded: Bool { get }
    // Начинает новую игру и сразу стартует первый раунд
    func restartGame()
    // Начинает новый раунд (обновляет загаданное число)
    func startNewRound()
    
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    typealias SecretType = T
    var score: Int = 0
    var secretValue: T
    private var compareClosure: (T,T) -> Int
    private var roundsCount: Int!
    private var currentRoundNumber: Int = 0
    var currentChoosenValue: Int = 0
    var currentChangeScore: Int = 0
    var isGameEnded: Bool {
        if currentRoundNumber == roundsCount {
            return true
        } else {
            return false
        }
    }
    
    init(secretValue: T, rounds: Int, compareClosure: @escaping (T,T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRound()
        
    }
        
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }

    func startNewRound() {
        currentRoundNumber += 1
        self.secretValue.setRandomValue()
    }

    func calculateScore(secretValue: T, userValue: T) {
        currentChangeScore = compareClosure(secretValue, userValue)
        score += currentChangeScore
    }
}
