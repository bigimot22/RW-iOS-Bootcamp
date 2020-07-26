//
//  OptionTableViewCell.swift
//  jQuiz
//
//  Created by Johandre Delgado  on 26.07.2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

  @IBOutlet private weak var label: UILabel!
  @IBOutlet private weak var background: UIView!

  var userSelected = false {
    didSet {
      background.backgroundColor = userSelected ? #colorLiteral(red: 0.6991786426, green: 0.4626978979, blue: 0.9533375287, alpha: 1) : .clear
    }
  }

  func setUp(with text: String) {
    self.label.text = text
    userSelected = false
    background.layer.borderWidth = 1
    background.layer.borderColor = UIColor.systemGray6.cgColor
    background.layer.cornerRadius = 10
  }

}
