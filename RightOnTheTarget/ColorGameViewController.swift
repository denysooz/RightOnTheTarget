//
//  ColorGameViewController.swift
//  RightOnTheTarget
//
//  Created by Denis Dareuskiy on 16.01.24.
//

import UIKit

class ColorGameViewController: UIViewController {
    
    var game: Game<SecretColorValue>!
    
    var correctButtonTag: Int = 0

    @IBOutlet var hexLabel: UILabel!
    @IBOutlet var buttonChoosenColor: UIButton!
    @IBOutlet var buttonSecretColor: UIButton!
    @IBOutlet var buttonColor1: UIButton!
    @IBOutlet var buttonColor2: UIButton!
    @IBOutlet var buttonColor3: UIButton!
    @IBOutlet var buttonColor4: UIButton!
    
    var buttonsCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonsCollection = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        updateScene()
    }
    
    @IBAction func compareValue (sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        var secretValue = game.secretValue
        game.calculateScore(secretValue: secretValue, userValue: userValue)
        if game.isGameEnded {
            showAlertWith(score: game.score)
            // Начинаем игру заново
            buttonChoosenColor.backgroundColor = nil
            buttonSecretColor.backgroundColor = nil
            game.restartGame()
        }
        else {
            buttonChoosenColor.backgroundColor = userValue.value.getByUIColor()
            buttonSecretColor.backgroundColor = secretValue.value.getByUIColor()
            game.startNewRound()
        }
        updateScene()
    }
    
    
    private func updateScene() {
        let secretColorString = game.secretValue.value.getByHEXString()
        updateLabel(label: hexLabel, newText: "Загаданный цвет: \(secretColorString)")
        let secret = game.secretValue.value.getByHEXString()
        print(secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    private func updateLabel (label: UILabel, newText: String) {
        label.text = newText
    }
    
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        correctButtonTag = Array(1...4).randomElement()!
        buttonsCollection.forEach { button in
            print(button.tag)
            if button.tag == correctButtonTag {
                button.backgroundColor = secretValue.value.getByUIColor()
            } else {
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                print(copySecretValueForButton.value.getByHEXString())
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
    }
    
    private func showAlertWith (score: Int){
        let alert = UIAlertController(title: "Игра окончена!", message: "Вы заработали \(score) очков!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
        self.present(alert, animated: true)
    }

}
