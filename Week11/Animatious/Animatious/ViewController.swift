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

  private lazy var animationObject: UIImageView = {
      let image = UIImageView()
      image.image =  #imageLiteral(resourceName: "ray_thermometer_window")//imageLiteral(resourceName: "appLogo")
      image.contentMode = .scaleAspectFit
      image.translatesAutoresizingMaskIntoConstraints = false
      return image
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(animationObject)
    addConstraintsToView()

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

  func addConstraintsToView() {
  // adding constraints to topViewForImage
  NSLayoutConstraint.activate([
  animationObject.leadingAnchor.constraint(equalTo: view.leadingAnchor),                         animationObject.trailingAnchor.constraint(equalTo: view.trailingAnchor),                        animationObject.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
  animationObject.heightAnchor.constraint(equalToConstant: 150)
  ])
//  heightAnchor = topImageView.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 0.3)
//  // the multiplier 0.3 means we are setting height of topViewForImage to the 30% of view's height.
//  heightAnchor?.isActive = true
//  // adding constraints to topImageView
//  NSLayoutConstraint.activate([
//  topImageView.centerXAnchor.constraint(equalTo: topViewForImage.centerXAnchor),
//  topImageView.centerYAnchor.constraint(equalTo:
//  topViewForImage.centerYAnchor),
//  topImageView.widthAnchor.constraint(equalTo: topViewForImage.widthAnchor, multiplier: 0.7),
//  topImageView.heightAnchor.constraint(equalTo: topViewForImage.heightAnchor, multiplier: 0.4)
//  ])
  }


}

