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
  private let picker = UIImagePickerController()
  private var pickedImage: UIImage?

  override func viewDidLoad() {
    super.viewDidLoad()
    datasource = MediaPostsHandler.shared
    setUpTableView()
    setUpImagePicker()
  }

  private func setUpTableView() {
    tableview.dataSource = self
    tableview.delegate = self
  }

  private func setUpImagePicker() {
    picker.delegate = self
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary
  }

  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
    pickedImage = nil
    showMessageInputFields()
  }

  @IBAction func didPressCreateImagePostButton(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      present(picker, animated: true, completion: nil)
    }
  }


  private func showMessageInputFields() {
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
      self.publishPost(sender: name, message: message, image: self.pickedImage)
    })

    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

    present(alert, animated: true)
  }

  private func publishPost(sender: String, message: String, image: UIImage?) {
    if let image = image {
      let post = ImagePost(textBody: message, userName: sender, timestamp: Date(), image: image)
      self.datasource.addImagePost(imagePost: post)
    } else {
      let post = TextPost(textBody: message, userName: sender, timestamp: Date())
      self.datasource.addTextPost(textPost: post)
    }
    DispatchQueue.main.async {
      self.tableview.reloadData()
    }
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
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info [UIImagePickerController.InfoKey.originalImage] {
      pickedImage = image as? UIImage
      dismiss(animated: true) {
        self.showMessageInputFields()
      }
    }
  }
}


