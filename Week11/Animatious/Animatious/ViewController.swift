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
  @IBOutlet private weak var notificationTopConstraint: NSLayoutConstraint!

  @IBOutlet private weak var playButton: UIButton!
  @IBOutlet private weak var leftButton: UIButton!
  @IBOutlet private weak var topButton: UIButton!
  @IBOutlet private weak var rightButton: UIButton!
  @IBOutlet private weak var notificationLabel: UILabel!
  @IBOutlet private weak var notificationView: UIView!

  private var showOptionButtons = false
  private var readyToAnimate = false
  private var showingBanner = false

  private var rotation = CGAffineTransform(rotationAngle: .pi / 1)
  private var scale = CGAffineTransform(scaleX: 1.0, y: 1.0)
  private var color = Colors.purple

  private lazy var animationObject: UIImageView = {
    let image = UIImageView()
    image.image =  #imageLiteral(resourceName: "logo-raywenderlich-250")
    image.contentMode = .scaleAspectFit
    image.layer.borderWidth = 10.0
    image.layer.masksToBounds = false
    image.layer.borderColor = Colors.purple.cgColor
    image.layer.cornerRadius =  75 // image.frame.size.height / 2
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()



  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(animationObject)
    addConstraintsToView()
    notificationTopConstraint.constant = -150
    resetAnimatableFields()

    showOptionButtons = false
    resetButtonsConstraints()
    setButtonsAlpha()

  }

  @IBAction private func didTapColorButton(_ sender: UIButton) {
    print("didTapColorButton: \(1)")
    color = Colors.active
    readyToAnimate = true
    let actionLabel = "Color".uppercased()
    showNotificationBanner(message: "\(actionLabel) animation added successfully!")

  }

  @IBAction private func didTapExpanseButton(_ sender: UIButton) {
    print("didTapExpanseButton: \(2)")
    scale = CGAffineTransform(scaleX: 1.3, y: 1.3)
    readyToAnimate = true
    let actionLabel = "Scale".uppercased()
    showNotificationBanner(message: "\(actionLabel) animation added successfully!")
  }

  @IBAction private func didTapRotateButton(_ sender: UIButton) {
    print("didTapRotateButton: \(3)")
    rotation = CGAffineTransform(rotationAngle: .pi / 1)
    readyToAnimate = true
    let actionLabel = "Rotation".uppercased()
    showNotificationBanner(message: "\(actionLabel) animation added successfully!")
  }

  @IBAction private func didTapPlay(_ sender: UIButton) {
    print("play button tapped. isOpen is: \(showOptionButtons)")
    if !showOptionButtons && readyToAnimate {
      playSelectedAnimations()
    } else {
      showOptionButtons.toggle()
      playButtonsAnimations()
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
      self.animationObject.layer.animateBorderColor(from: Colors.purple, to: self.color, withDuration: 0.3)
    }) { _ in
      self.resetAnimationObject()
    }

  }

  private func resetAnimationObject() {
    UIView.animate(withDuration: 0.6, animations: {
      self.animationObject.transform = CGAffineTransform.identity
      self.animationObject.backgroundColor = .clear
      self.animationObject.layer.animateBorderColor(from: self.color, to: Colors.purple, withDuration: 0.2)
      self.readyToAnimate = false
      self.playButton.tintColor = Colors.purple
    }) { _ in
      self.resetAnimatableFields()
    }
  }

  private func resetAnimatableFields() {
    self.color = Colors.purple
    self.rotation = self.animationObject.transform
    self.scale = self.animationObject.transform
  }

  private func showNotificationBanner(message: String) {
    notificationLabel.text = message
    if showingBanner {
      return
    }
    showingBanner = true
    view.bringSubviewToFront(notificationView)
    notificationTopConstraint.constant = 12
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
    }) { _ in
      self.notificationTopConstraint.constant = -150
      UIView.animate(withDuration: 0.3, delay: 0.8, animations:  {
        self.view.layoutIfNeeded()
      }) { _ in
        self.notificationLabel.text = ""
        self.showingBanner = false
      }
    }

  }

  func addConstraintsToView() {
    NSLayoutConstraint.activate([
      animationObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      animationObject.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -90),
      animationObject.widthAnchor.constraint(equalToConstant: 150),
      animationObject.heightAnchor.constraint(equalToConstant: 150)
    ])

  }


}

