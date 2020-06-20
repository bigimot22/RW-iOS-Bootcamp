//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var questionLabel: UILabel!

  var compatibilityItems = ["Cats", "Dogs", "Hamsters"] // Add more!
  var currentItemIndex = 0

  var person1 = Person(id: 1, items: [:])
  var person2 = Person(id: 2, items: [:])
  var currentPerson: Person?

  override func viewDidLoad() {
    super.viewDidLoad()
    setToInitialValues()
  }

  @IBAction func sliderValueChanged(_ sender: UISlider) {
    print(sender.value)
  }

  @IBAction func didPressNextItemButton(_ sender: Any) {
    print("didPressNextItemButton currentItem: \(compatibilityItems[currentItemIndex])")
    let currentItem = compatibilityItems[currentItemIndex]
    currentPerson?.items.updateValue(slider.value, forKey: currentItem)

    currentItemIndex += 1

    if currentItemIndex >= compatibilityItems.count {
      setNextPersonOrFinish()
    } else {
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    }



  }

  private func setNextPersonOrFinish() {
    if currentPerson == person2 {
      showResult()
    } else {
      currentPerson = person2
      setTitle(personNumber: currentPerson!.id)
      currentItemIndex = 0
      compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    }
  }



  private func setToInitialValues() {
    currentPerson = person1
    setTitle(personNumber: currentPerson!.id)
    currentItemIndex = 0
    compatibilityItemLabel.text = "\(compatibilityItems[currentItemIndex])"
    slider.value = 0.5
  }

  private func setTitle(personNumber: Int) {
    questionLabel.text = "Person \(personNumber), what do you think about..."
  }

  private func showResult() {
    let score = calculateCompatibility()
    let alert = UIAlertController(title: "Results", message: "You both are \(score) compatible!", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
      self.setToInitialValues()
    })
    alert.addAction(action)
    present(alert, animated: true)
  }

  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    var percentagesForAllItems: [Double] = []

    for (key, person1Rating) in person1.items {
      let person2Rating = person2.items[key] ?? 0
      let difference = abs(person1Rating - person2Rating)/5.0
      percentagesForAllItems.append(Double(difference))
    }

    let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
    let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
    print(matchPercentage, "%")
    let matchString = 100 - (matchPercentage * 100).rounded()
    return "\(matchString)%"
  }

}

