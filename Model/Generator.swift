//
//  Generator.swift
//  RightOnTheTarget
//
//  Created by Denis Dareuskiy on 15.01.24.
//

import Foundation

protocol GeneratorProtocol {
    func getRandomValue() -> Int
}

class Generator: GeneratorProtocol {
    private let startRangeValue: Int
    private let endRangeValue: Int
    
    init?(startValue: Int, endValue: Int) {
        guard startValue <= endValue else {
            return nil
        }
        startRangeValue = startValue
        endRangeValue = endValue
    }
    
    func getRandomValue() -> Int {
        (startRangeValue...endRangeValue).randomElement()!
    }
}
