/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
  @IBOutlet private weak var targetLabel: UILabel!
  @IBOutlet private weak var targetTextLabel: UILabel!
  @IBOutlet private weak var guessLabel: UILabel!
  
  @IBOutlet private weak var redLabel: UILabel!
  @IBOutlet private weak var greenLabel: UILabel!
  @IBOutlet private weak var blueLabel: UILabel!

  @IBOutlet private weak var redSlider: UISlider!
  @IBOutlet private weak var greenSlider: UISlider!
  @IBOutlet private weak var blueSlider: UISlider!

  @IBOutlet private weak var roundLabel: UILabel!
  @IBOutlet private weak var scoreLabel: UILabel!
  
  private let game = BullsEyeGame()
  private var rgb = RGB()
  
  @IBAction private func aSliderMoved(sender: UISlider) {
    switch sender {
    case redSlider:
      rgb.r = Int(sender.value.rounded())
    case greenSlider:
      rgb.g = Int(sender.value.rounded())
    case blueSlider:
      rgb.b = Int(sender.value.rounded())
    default:
      return
    }
    updateView()
  }
  
  @IBAction private func showAlert(sender: AnyObject) {
    guessLabel.backgroundColor = UIColor(rgbStruct: rgb)
    game.playColor(rgb)
    let title = game.feedback
    let message = "You scored \(game.points) points"
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      self.game.startNewRound()
      self.updateView()
    })
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction private func startOver(sender: AnyObject) {
    game.startNewGame()
    updateView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewGame()
    updateView()
  }

  private func updateView() {
    targetLabel.backgroundColor = UIColor(rgbStruct: game.targetColor)
    redLabel.text = rgb.r.description
    greenLabel.text = rgb.g.description
    blueLabel.text = rgb.b.description
    scoreLabel.text = "Score: \(game.score)"
    roundLabel.text = "Round: \(game.round)"

  }
}

