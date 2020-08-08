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

  @IBOutlet private weak var playButton: UIButton!
  @IBOutlet private weak var leftButton: UIButton!
  @IBOutlet private weak var topButton: UIButton!
  @IBOutlet private weak var rightButton: UIButton!

  private var showOptionButtons = false
  private var readyToAnimate = false

  private var rotation = CGAffineTransform(rotationAngle: .pi / 1)
  private var scale = CGAffineTransform(scaleX: 1.3, y: 1.3)
  private var translation = CGAffineTransform(translationX: 200, y: 0)
  private var color = Colors.active

  private lazy var animationObject: UIImageView = {
      let image = UIImageView()
      image.image =  #imageLiteral(resourceName: "ray_thermometer_window")
      image.contentMode = .scaleAspectFit
      image.translatesAutoresizingMaskIntoConstraints = false
      return image
  }()

  private var playFeedbackColor: UIColor = .purple {
    didSet {
      playButton.tintColor = playFeedbackColor
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(animationObject)
    addConstraintsToView()

    showOptionButtons = false
    resetButtonsConstraints()
    setButtonsAlpha()

  }

  @IBAction private func didTapColorButton(_ sender: UIButton) {
    print("didTapColorButton: \(1)")

  }

  @IBAction private func didTapExpanseButton(_ sender: UIButton) {
    print("didTapExpanseButton: \(2)")
    readyToAnimate = true
  }

  @IBAction private func didTapRotateButton(_ sender: UIButton) {
    print("didTapRotateButton: \(3)")
  }

  @IBAction private func didTapPlay(_ sender: UIButton) {
    print("play button tapped. isOpen is: \(showOptionButtons)")
    if !showOptionButtons && readyToAnimate {
      playSelectedAnimations()
    } else {
      showOptionButtons.toggle()
      playButtonsAnimations()
//      if readyToAnimate {
//        sender.tintColor = .yellow
//      }
    }

  }

  private func playButtonsAnimations() {
    resetButtonsConstraints()

    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
      self.setButtonsAlpha()
      self.playButton.tintColor = self.readyToAnimate ? Colors.active : Colors.purple
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
    UIView.animate(withDuration: 1, animations: {
      self.animationObject.transform = self.scale.concatenating(self.rotation)
      self.animationObject.backgroundColor = self.color
    }) { _ in
      self.resetAnimationObject()
    }

  }

  private func resetAnimationObject() {
    UIView.animate(withDuration: 0.6) {
      self.animationObject.transform = CGAffineTransform.identity
      self.animationObject.backgroundColor = .clear
      self.readyToAnimate = false
      self.playButton.tintColor = Colors.purple
    }
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

