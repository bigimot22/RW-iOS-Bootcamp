//
//  TextPostCell.swift
//  Birdie-Final
//
//  Created by Johandre Delgado  on 28.06.2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

  @IBOutlet private weak var senderLabel: UILabel!
  @IBOutlet private weak var timestampLabel: UILabel!
  @IBOutlet private weak var messageLabel: UILabel!

  func configure(with model: MediaPost) {
    senderLabel.text = model.userName
    timestampLabel.text = model.timestamp.toString()
    messageLabel.text = model.textBody ?? ""
  }

}



class ImagePostCell: PostCell {
  @IBOutlet private weak var messageImageView: UIImageView!

  func configure(with model: MediaPost, image: UIImage) {
    super.configure(with: model)
    setMessageImage(image)
  }


  private func setMessageImage(_ image: UIImage) {
    messageImageView.image = image
  }
}
