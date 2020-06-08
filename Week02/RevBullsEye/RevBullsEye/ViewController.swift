//
//  ViewController.swift
//  RevBullsEye
//
//  Created by Johandre Delgado  on 08.06.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  private let game = BullsEyeGame()

  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var guessTextField: UITextField!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
    guessTextField.keyboardType = .numberPad
    guessTextField.clearButtonMode = .always
  }

  @IBAction func showAlert() {
    guessTextField.resignFirstResponder()
    let input = guessTextField.text ?? ""
    if let value = Int(input) {
      game.playValue(value)
    }
    let title = game.feedback
    let message = "You scored \(game.points) points"
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      self.game.startNewRound()
      self.updateViews()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

  @IBAction func startNewGame() {
    game.startNewGame()
    updateViews()
  }

  func updateViews() {
    slider.value = Float(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }

}

