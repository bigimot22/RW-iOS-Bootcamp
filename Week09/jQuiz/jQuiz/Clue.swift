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
  var value: Int? = 0

}

struct Category: Codable {
  let id: Int
  let title: String
}
