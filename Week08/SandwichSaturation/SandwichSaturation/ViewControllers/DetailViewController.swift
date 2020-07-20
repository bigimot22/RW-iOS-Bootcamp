//
//  DetailViewController.swift
//  SandwichSaturation
//
//  Created by Johandre Delgado  on 20.07.2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var sauceLabel: UILabel!
  var sandwich: Sandwich!

    override func viewDidLoad() {
        super.viewDidLoad()

      print("sandwich: \(sandwich.name)")
      imageView.image = UIImage(named: sandwich.imageName)
      titleLabel.text = sandwich.name
      sauceLabel.text = "Sauce: \(sandwich.sauceAmount.description)"

    }
    



}
