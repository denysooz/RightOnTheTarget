//
//  ViewController.swift
//  RightOnTheTarget
//
//  Created by Denis Dareuskiy on 12.01.24.
//

import UIKit



class NumberGameViewController: UIViewController {
    
    // Сущность "Игра"
    var game: Game<SecretNumberValue>!
    var startValue: Int = 0
    var endValue: Int = 0
    // Элементы на сцене
    @IBOutlet var slider: UISlider!
    @IBOutlet var labelBalanceAndChosenValue: UILabel!
    @IBOutlet var labelSecretValue: UILabel!

    // MARK: - Жизненный цикл
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startValue = Int(slider.minimumValue)
        endValue = Int(slider.maximumValue)
        game = (GameFactory.getNumberGame() as! Game<SecretNumberValue>)
        updateLabel(label: labelSecretValue, newText: "Загаданное число: \(game.secretValue.value)")
    }
    
    // MARK: - Взаимодействие View - Model
    
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        // Высчитываем очки за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // Начинаем игру заново
            game.restartGame()
            updateLabel(label: labelBalanceAndChosenValue, newText: "Ваш баланс: \(game.score)")
        }
        else {
            updateLabel(label: labelBalanceAndChosenValue, newText: "Ваш баланс: \(game.score)(+\(game.currentChangeScore)). Вы выбрали число \(userSecretValue.value)")
            game.startNewRound()
            
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabel(label: labelSecretValue, newText: "Загаданное число: \(game.secretValue.value)")
    }
    
    // MARK: - Обновление View
    // Обновление текста
    private func updateLabel (label: UILabel, newText: String) {
        label.text = newText
    }
    
    // Отображение всплывающего окна со счетом
    private func showAlertWith (score: Int){
        let alert = UIAlertController(title: "Игра окончена!", message: "Вы заработали \(score) очков!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
        self.present(alert, animated: true)
    }
}

