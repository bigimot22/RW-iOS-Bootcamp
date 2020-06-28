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
    tableview.dataSource = self
    tableview.delegate = self
  }

  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
    let alert = UIAlertController(title: "What's up? :]", message: nil, preferredStyle: .alert)

    alert.addTextField { (textField) in
      textField.placeholder = "Your Name"
      textField.autocapitalizationType = .sentences
    }
    alert.addTextField { (textField) in
      textField.placeholder = "Your Message..."
      textField.autocapitalizationType = .sentences
      textField.autocorrectionType = .yes
    }

    alert.addAction(UIAlertAction(title: "Send", style: .default) { (action) in
      let name = alert.textFields?[0].text ?? ""
      let message = alert.textFields?[1].text ?? ""
      if name.isEmpty || message.isEmpty {
        return
      }

      let post = TextPost(textBody: message, userName: name, timestamp: Date())
      self.datasource.addTextPost(textPost: post)
      DispatchQueue.main.async {
        self.tableview.reloadData()
      }
    })

    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

    present(alert, animated: true)
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


