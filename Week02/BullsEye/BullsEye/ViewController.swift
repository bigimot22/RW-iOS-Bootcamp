//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//  Updated by Johandre Delgado on 6/7/2020
//

import UIKit

class ViewController: UIViewController {
  private let game = BullsEyeGame()
  private let defaultSliderValue: Float = 50.0
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

  var selectedValue: Int {
    return Int(slider.value.rounded())
  }
  var quickDiff: Int {
    return abs(game.targetValue - selectedValue)
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
  }

  @IBAction private func sliderDidMove(_ sender: UISlider) {
    slider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)

  }

  @IBAction func showAlert() {
    game.playValue(selectedValue)

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
    slider.value = defaultSliderValue
    updateViews()
  }

  func updateViews() {
    setSliderTint()
    targetLabel.text = String(game.targetValue)
    scoreLabel.text = String(game.score)
    roundLabel.text = String(game.round)
  }

  private func setSliderTint() {
    slider.minimumTrackTintColor =
    UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0)

  }
  
}



