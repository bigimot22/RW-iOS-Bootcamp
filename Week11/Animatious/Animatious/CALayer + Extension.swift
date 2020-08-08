//
//  CALayer + Extension.swift
//  Animatious
//
//  Created by Johandre Delgado  on 08.08.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import UIKit

extension CALayer {

  func animateBorderColor(from startColor: UIColor, to endColor: UIColor, withDuration duration: Double) {
    let colorAnimation = CABasicAnimation(keyPath: "borderColor")
    colorAnimation.fromValue = startColor.cgColor
    colorAnimation.toValue = endColor.cgColor
    colorAnimation.duration = duration
    self.borderColor = endColor.cgColor
    self.add(colorAnimation, forKey: "borderColor")
  }
}
