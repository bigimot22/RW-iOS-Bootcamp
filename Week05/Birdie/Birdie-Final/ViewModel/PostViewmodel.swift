//
//  PostViewmodel.swift
//  Birdie-Final
//
//  Created by Johandre Delgado  on 29.06.2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class PostViewmodel {
//  static let shared = MediaPostsViewModel()

  func setUpTableViewCell(for model: MediaPost, in tableview: UITableView) -> UITableViewCell {
      if let textPost = model as? TextPost {
          let cell = tableview.dequeueReusableCell(withIdentifier: "postcell") as! PostCell
        cell.configure(with: textPost)
//          cell.nameLabel.text = post.userName
//          cell.timestampLabel.text = post.timestamp.toString()
//          cell.textBodyLabel.text = post.textBody
          return cell
      } else if let imagePost = model as? ImagePost {
          let cell = tableview.dequeueReusableCell(withIdentifier: "imagecell") as! ImagePostCell
        cell.configure(with: imagePost, image: imagePost.image)
//          cell.nameLabel.text = post.userName
//          cell.timestampLabel.text = post.timestamp.toString()
//          cell.textBodyLabel.text = post.textBody
//          cell.postImageView.image = post.image
          return cell
      } else {
          let cell = UITableViewCell()
          cell.textLabel?.text = model.textBody
          return cell
      }
  }
}
