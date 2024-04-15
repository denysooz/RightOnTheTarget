//
//  GameFactory.swift
//  RightOnTheTarget
//
//  Created by Denis Dareuskiy on 16.01.24.
//

import Foundation

final class GameFactory {
    
    static func getNumberGame() -> some GameProtocol {
        let minSecretValue = 1
        let maxSecretValue = 50
        let sliderValueRange = maxSecretValue - minSecretValue + 1
        let secretValue = SecretNumberValue(initialValue: 0) { _ in 
            return (minSecretValue...maxSecretValue).randomElement()! }
        return Game<SecretNumberValue>(secretValue: secretValue, rounds: 5) { secretValue, userValue in
            var compareResult: Int!
            if secretValue.value > userValue.value {
                compareResult = sliderValueRange - (secretValue.value - userValue.value)
            } else if secretValue.value < userValue.value {
                compareResult = sliderValueRange - (userValue.value - secretValue.value)
            } else {
                compareResult = sliderValueRange
            }
            return compareResult
        }
    }
    
    static func getColorGame() -> some GameProtocol {
        let initialSecretColor = Color()
        var secretValue = SecretColorValue(initialValue: initialSecretColor) { color in
            var updatedColor = color
            updatedColor.red = (0...255).randomElement()!
            updatedColor.green = (0...255).randomElement()!
            updatedColor.blue = (0...255).randomElement()!
            return updatedColor
        }
        return Game<SecretColorValue>(secretValue: secretValue, rounds: 5) { secretValue, userValue in
            if secretValue.value == userValue.value {
                return 1
            } else {
                return 0
            }
        }
        
    }
}
