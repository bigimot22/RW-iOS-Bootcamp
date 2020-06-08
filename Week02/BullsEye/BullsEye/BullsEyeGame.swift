//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Johandre Delgado  on 07.06.2020.
//  Copyright © 2020 Johandre Delgado. All rights reserved.
//

import Foundation

final class BullsEyeGame {
  private (set) var targetValue = 0
  private (set) var score = 0
  private (set) var points = 0
  private (set) var round = 0
  private (set) var feedback: String = ""


  func playValue(_ value: Int) {
    let difference = abs(targetValue - value)
    points = 100 - difference
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

  func startNewRound() {
    round += 1
    targetValue = Int.random(in: 1...100)
  }

  func startNewGame() {
    score = 0
    round = 0
    startNewRound()
  }

}
