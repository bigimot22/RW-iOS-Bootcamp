//
//  QuestionViewModel.swift
//  jQuiz
//
//  Created by Johandre Delgado  on 27.07.2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct QuestionViewModel {
  let categoryTitle: String
  let question: String
  let correctAnswer: String
  let options: [String]
  let points: String

  init(clues: [Clue]) {
    let firstClue = clues.first
    categoryTitle = firstClue?.category.title ?? "Category"
    question = firstClue?.question ?? "Question"
    correctAnswer = firstClue?.answer ?? "Answer"
    points = String(firstClue?.points ?? 100)
    var opts = [String]()
    for clue in clues {
      opts.append(clue.answer)
    }
    options = opts.shuffled()
  }
}
