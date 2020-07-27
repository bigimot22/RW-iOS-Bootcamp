//
//  ImageCache.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/19/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIImageView {
  public static var webImageStore: [String: UIImage] = [:]

  public static func image(for url: URL) -> UIImage? {
    if let image = webImageStore[url.absoluteString] {
      return image
    }
    return nil
  }

  public static func image(for imageName: String) -> UIImage? {
    if let image = webImageStore[imageName] {
      return image
    }
    return nil
  }

  public static func insertImage(_ image: UIImage, for url: URL) {
    webImageStore[url.absoluteString] = image
  }

  public static func insertImage(_ image: UIImage, for imageName: String) {
    webImageStore[imageName] = image
  }

}
