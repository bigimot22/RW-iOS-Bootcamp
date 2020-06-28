//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

  var datasource: MediaPostsHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
      datasource = MediaPostsHandler.shared
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
      tableview.dataSource = self
      tableview.delegate = self
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return datasource.mediaPosts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = datasource.mediaPosts[indexPath.row]

    if let textPost = model as? TextPost {
      let cell = tableView.dequeueReusableCell(withIdentifier: "postcell") as! PostCell
      cell.configure(with: textPost)
      return cell
    } else if let imagePost = model as? ImagePost {
      let cell = tableView.dequeueReusableCell(withIdentifier: "imagecell") as! ImagePostCell
      cell.configure(with: model, image: imagePost.image)
      return cell
    }

    return UITableViewCell.init()
  }


}


extension ViewController: UITableViewDelegate {

}


