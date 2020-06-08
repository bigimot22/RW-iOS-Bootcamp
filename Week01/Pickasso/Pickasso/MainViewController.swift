//
//  ViewController.swift
//  Pickasso
//
//  Created by Johandre Delgado  on 30.05.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  @IBOutlet private weak var colorNameLabel: UILabel!
  @IBOutlet private weak var redAmountLabel: UILabel!
  @IBOutlet private weak var greenAmountLabel: UILabel!
  @IBOutlet private weak var blueAmountLabel: UILabel!
  @IBOutlet private weak var infoButton: UIButton!
  @IBOutlet private weak var redSlider: UISlider!
  @IBOutlet private weak var greenSlider: UISlider!
  @IBOutlet private weak var blueSlider: UISlider!
  @IBOutlet private weak var colorPreview: UIView!

  private var currentColorName = "Choose a color" {
    didSet {
      colorNameLabel.text = "\(currentColorName) \nred: \(redAmount), green: \(greenAmount), blue: \(blueAmount)"
    }
  }

  private var redAmount = 0 {
    didSet {
      redAmountLabel.text = String(redAmount)
    }
  }

  private var greenAmount = 0 {
    didSet {
      greenAmountLabel.text = String(greenAmount)
    }
  }

  private var blueAmount = 0 {
    didSet {
      blueAmountLabel.text = String(blueAmount)
    }
  }

  private var selectedColor: UIColor = .clear
  private var invertedColor: UIColor = .systemBlue

  // MARK: - LIFE CYCLE METHODS

  override func viewDidLoad() {
    super.viewDidLoad()

    colorPreview.layer.cornerRadius = colorPreview.frame.width / 2
    colorPreview.layer.borderWidth = 1
    resetUI()
  }

  // MARK: - @IBACTIONS

  @IBAction private func didChangeRedValue(_ sender: UISlider) {
    redAmount = Int(sender.value)
    createColorsFromInputs()
    setPreview()
  }

  @IBAction private func didChangeGreenValue(_ sender: UISlider) {
    greenAmount = Int(sender.value)
    createColorsFromInputs()
    setPreview()
  }

  @IBAction private func didChangeBlueValue(_ sender: UISlider) {
    blueAmount = Int(sender.value)
    createColorsFromInputs()
    setPreview()
  }

  @IBAction private func didTapSetColorButton(_ sender: UIButton) {
    //        createColorsFromInputs()
    showAlertForColorInput()
  }

  @IBAction private func didTapResetButton(_ sender: UIButton) {
    resetUI()
  }

  // MARK: - METHODS
  private func showAlertForColorInput() {
    let alert = UIAlertController(title: "Color Name",
                                  message: "Set a name for your new color.",
                                  preferredStyle: .alert)
    let rect = CGRect(x: 5, y: 5, width: 30, height: 30)
    let extraColorPreview = UIView(frame: rect)
    extraColorPreview.layer.cornerRadius = 15
    extraColorPreview.backgroundColor = selectedColor
    extraColorPreview.layer.borderWidth = 1
    extraColorPreview.layer.borderColor = UIColor.systemGray2.cgColor
    alert.view.addSubview(extraColorPreview)
    alert.addTextField()
    alert.textFields?[0].autocapitalizationType = .words
    alert.textFields?[0].keyboardType = .default
    alert.textFields?[0].autocorrectionType = .yes
    alert.textFields?[0].clearButtonMode = .whileEditing
    let action = UIAlertAction(title: "Accept", style: .default) { [unowned alert] _ in
      var colorName = alert.textFields?[0].text ?? "Unnamed Color"
      if colorName.isEmpty { colorName = "Unnamed Color" }
      self.setBackgroundColor(named: colorName)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(action)
    alert.addAction(cancelAction)
    present(alert, animated: true)
  }

  private func setBackgroundColor(named colorName: String) {
    view.backgroundColor = selectedColor
    infoButton.tintColor = invertedColor
    currentColorName = colorName
  }

  private func createColorsFromInputs() {
    let maximumColorAmount: CGFloat = 255.0
    let red = CGFloat(redAmount)/maximumColorAmount
    let green = CGFloat(greenAmount)/maximumColorAmount
    let blue = CGFloat(blueAmount)/maximumColorAmount
    selectedColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    invertedColor = UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: 1.0)
  }

  private func setPreview() {
    colorPreview.backgroundColor = selectedColor
    colorPreview.layer.borderColor = invertedColor.cgColor
  }

  private func resetUI() {
    redAmount = 0
    greenAmount = 0
    blueAmount = 0
    redSlider.value = 0
    greenSlider.value = 0
    blueSlider.value = 0
    createColorsFromInputs()
    setBackgroundColor(named: "Black")
    setPreview()
  }
}
