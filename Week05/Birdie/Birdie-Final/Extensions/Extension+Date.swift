//
//  Extension+Date.swift
//  Birdie-Final
//
//  Created by Johandre Delgado  on 28.06.2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

extension Date {

  func toString() -> String {
      let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM, HH:MM"
      return dateFormatter.string(from: self)
  }

}
