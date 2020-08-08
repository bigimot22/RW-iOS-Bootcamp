//
//  ViewController.swift
//  Animatious
//
//  Created by Johandre Delgado  on 08.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var leftButtonLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private weak var topButtonBottomConstraint: NSLayoutConstraint!
  @IBOutlet private weak var rightButtonTrailingConstraint: NSLayoutConstraint!

  @IBOutlet private weak var leftButton: UIButton!
  @IBOutlet private weak var topButton: UIButton!
  @IBOutlet private weak var rightButton: UIButton!

  private var showOptionButtons = false

  override func viewDidLoad() {
    super.viewDidLoad()

    showOptionButtons = false
    resetButtonsConstraints()
    setButtonsAlpha()

  }

  @IBAction private func didTapPlay(_ sender: UIButton) {
    print("play button tapped. isOpen is: \(showOptionButtons)")
    showOptionButtons.toggle()
    playButtonsAnimations()
  }

  private func playButtonsAnimations() {
    resetButtonsConstraints()

    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
      self.setButtonsAlpha()
    }
  }

  private func resetButtonsConstraints() {
    self.leftButtonLeadingConstraint.constant = self.showOptionButtons ? -100 : 0
    self.topButtonBottomConstraint.constant = self.showOptionButtons ? -100 : 0
    self.rightButtonTrailingConstraint.constant = self.showOptionButtons ? 100 : 0
  }

  private func setButtonsAlpha() {
    self.leftButton.alpha = self.showOptionButtons ? 1 : 0
    self.topButton.alpha = self.showOptionButtons ? 1 : 0
    self.rightButton.alpha = self.showOptionButtons ? 1 : 0
  }

  private func playSelectedAnimations() {

  }


}

