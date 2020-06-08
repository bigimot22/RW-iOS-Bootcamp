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

import Foundation

class BullsEyeGame {
  private (set) var targetValue = 0
  private (set) var score = 0
  private (set) var points = 0
  private (set) var round = 0
  private (set) var feedback: String = ""


  private (set) var targetColor = RGB(r: 0, g: 0, b: 0)
  private (set) var selectedColor = RGB(r: 0, g: 0, b: 0)

  func playColor(_ value: RGB) {
    let rawDifference = value.difference(target: targetColor)
    let normalizedDifference = rawDifference * 100
    let difference = normalizedDifference.rounded()
    points = Int(100 - difference)
    if difference == 0 {
      feedback = "Perfect!"
      points += 100
    } else if difference < 5 {
      feedback = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      feedback = "Pretty good!"
    } else {
      feedback = "Not even close..."
    }
    score += points
  }

  func startNewGame() {
    score = 0
    round = 0
    startNewRound()
  }

  func startNewRound() {
    round += 1
    targetColor = getRadomRGB()
  }

  private func getRadomRGB() -> RGB {
    let red = Int.random(in: 0...255)
    let green = Int.random(in: 0...255)
    let blue = Int.random(in: 0...255)
    return RGB(r: red, g: green, b: blue)
  }

}
