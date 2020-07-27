//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Clue: Codable {
  let question: String
  let answer: String
  let category: Category
  var points: Int? = 0
  var date: String

  enum CodingKeys: String, CodingKey {
      case date = "created_at"
    case points = "value"
    case question, answer, category
  }

}

struct Category: Codable {
  let id: Int
  let title: String
  let count: Int

  // clues_count
  enum CodingKeys: String, CodingKey {
      case count = "clues_count"
    case id, title
  }
}
