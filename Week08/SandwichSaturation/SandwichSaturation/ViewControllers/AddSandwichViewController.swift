//
//  AddSandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

class AddSandwichViewController: UIViewController {
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  let imageName: String
  var sauceAmount: SauceAmount!

  var delegate: SandwichDataSource?
  
  required init?(coder: NSCoder) {
    imageName = AddSandwichViewController.randomImageName()
    sauceAmount = SauceAmount.none

    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    imageView.image = UIImage.init(imageLiteralResourceName: imageName)
  }
  
  class func randomImageName() -> String {
    let sandwichNum = Int.random(in: 1...15)
    return "sandwich\(sandwichNum)"
  }
  
  @IBAction func sauceAmountChanged(_ sender: UISegmentedControl) {
    sauceAmount = SauceAmount(rawValue: sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "None")
  }
  
  @IBAction func cancelPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func savePressed(_ sender: Any) {
    guard let sandwichName = nameField.text,
      !sandwichName.isEmpty else {
        let alert = UIAlertController(title: "Missing Name",
                                      message: "You need to enter a sandwich name!",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        return
    }

    delegate?.saveSandwich(name: sandwichName, sauceAmount: sauceAmount.rawValue, imageName: imageName)
    dismiss(animated: true, completion: nil)
  }
}

extension AddSandwichViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}
