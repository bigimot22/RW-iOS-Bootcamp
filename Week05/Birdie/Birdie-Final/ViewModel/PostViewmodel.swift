//
//  PostViewmodel.swift
//  Birdie-Final
//
//  Created by Johandre Delgado  on 29.06.2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class PostViewmodel {

  func setUpTableViewCell(for model: MediaPost, in tableview: UITableView) -> UITableViewCell {
    if let textPost = model as? TextPost {
      let cell = tableview.dequeueReusableCell(withIdentifier: "postcell") as! PostCell
      cell.configure(with: textPost)
      return cell
    } else if let imagePost = model as? ImagePost {
      let cell = tableview.dequeueReusableCell(withIdentifier: "imagecell") as! ImagePostCell
      cell.configure(with: imagePost, image: imagePost.image)
      return cell
    } else {
      let cell = UITableViewCell()
      cell.textLabel?.text = model.textBody
      return cell
    }
  }
}
