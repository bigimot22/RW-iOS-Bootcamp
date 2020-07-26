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


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

  func setUp(with text: String) {
    self.label.text = text
    background.layer.borderWidth = 1
    background.layer.borderColor = UIColor.systemGray6.cgColor
    background.layer.cornerRadius = 10
  }

}
