//
//  GameRound.swift
//  RightOnTheTarget
//
//  Created by Denis Dareuskiy on 15.01.24.
//

import Foundation

protocol GameRoundProtocol {
    
    var score: Int { get }
    var currentSecretValue: Int { get }
    var currentChoosenValue: Int { get }
    var currentChangeScore: Int { get }
    var differnceEndAndStartValues: Int{ get }
    
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {
    // общее количество очков
    var score: Int = 0
    // загаданное значение
    var currentSecretValue: Int = 0
    // значение выбранное на слайдере
    var currentChoosenValue: Int = 0
    // изменение очков
    var currentChangeScore: Int = 0
    // разница между конечный и первым числом в диапазоне слайдера
    var differnceEndAndStartValues: Int = 0
    
    init?(startValue: Int, endValue: Int, secretValue: Int) {
        // Стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        self.differnceEndAndStartValues = endValue - startValue + 1
        self.currentSecretValue = secretValue
    }
    
    init?(startValue: Int, endValue: Int) {
        // Стартовое значение для выбора случайного числа не может быть больше конечного
        guard startValue <= endValue else {
            return nil
        }
        self.differnceEndAndStartValues = endValue - startValue + 1
    }
    
    func calculateScore(with value: Int) {
        self.currentChoosenValue = value
        if value > currentSecretValue {
            currentChangeScore = differnceEndAndStartValues - value + currentSecretValue
        } else if value < currentSecretValue {
            currentChangeScore = differnceEndAndStartValues - currentSecretValue + value
        } else {
            currentChangeScore = differnceEndAndStartValues
        }
        score += currentChangeScore
    }
}
