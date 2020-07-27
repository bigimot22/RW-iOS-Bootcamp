//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet private weak var logoImageHeightConstraint : NSLayoutConstraint!
  @IBOutlet private weak var feedbackIcon: UIImageView!
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet private weak var pointsLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!

  var userScore = 0 {
    didSet {
      if userScore < 0 { userScore = 0}
      scoreLabel.text = "Score: \(userScore)"
    }
  }

  var viewmodel: QuestionViewModel? = nil {
    didSet {
      DispatchQueue.main.async {
        guard let viewmodel = self.viewmodel else {
          print("JD: - Not viewmodel")
          return }
        self.categoryLabel.text = viewmodel.categoryTitle.uppercased()
        self.pointsLabel.text = "for \(viewmodel.points) points"
        self.clueLabel.text = viewmodel.question
        self.tableView.reloadData()
        self.feedbackIcon.image = UIImage(systemName: "questionmark.circle.fill")
        self.feedbackIcon.tintColor = .systemGray6
      }
    }
  }



  // MARK: - LIFE CYCLE METHODS

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.isScrollEnabled = false

    setupSoundUI()

    setUpView()
    getNextQuestion()
    
  }

  private func getNextQuestion() {
    print("JD: - Going to call network...")
    Networking.sharedInstance.getRandomCategory(completion: { (categoryId, cluesCount) in
      guard let id = categoryId else { return }
      let ofsset = cluesCount <= 4 ? 0 : cluesCount - 4
      Networking.sharedInstance.getAllCluesInCategory(categoryId: id, offset: ofsset) { clues in
        guard let clues = clues else { return }
        self.viewmodel = QuestionViewModel(clues: clues)
      }
      
    })
    
  }
  
  private func setUpView() {
    if let image = UIImageView.image(for: "webHeaderImage") {
      self.logoImageView.image = image
    } else {
      Networking.sharedInstance.getHeaderImage { (data) in
        if let data = data {
          DispatchQueue.main.async {
            guard let image = UIImage(data: data) else { return }
            self.logoImageView.image = image
            UIImageView.insertImage(image, for: "webHeaderImage")
          }
        }
      }
    }
  }

  func setupSoundUI() {
    if SoundManager.shared.isSoundEnabled {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
      SoundManager.shared.playSound()
    } else {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
      SoundManager.shared.stopSounds()
    }
  }
  
  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    setupSoundUI()
  }

  private func processUserSelection(selection: String) {
    if selection == viewmodel?.correctAnswer {
      print("Correct answer selected: \(selection)")
      userScore += Int(viewmodel?.points ?? "0") ?? 0
      feedbackIcon.image = UIImage(systemName: "checkmark.circle.fill")
      feedbackIcon.tintColor = .systemGreen
    } else {
      print("Incorrect answer selected: \(selection) - \nCorrect is: \(String(describing: viewmodel?.correctAnswer))")
      userScore -= Int(viewmodel?.points ?? "0") ?? 0
      feedbackIcon.image = UIImage(systemName: "xmark.circle.fill")
      feedbackIcon.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.getNextQuestion()
    }
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewmodel?.options.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath) as! OptionTableViewCell

    if let option = viewmodel?.options[indexPath.row] {
      cell.setUp(with: option)
      
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! OptionTableViewCell
    cell.userSelected = true
    if let answer = viewmodel?.options[indexPath.row] {
      processUserSelection(selection: answer)
    }
  }
}


extension ViewController {

  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight{
      logoImageHeightConstraint.constant = 0
    }
    else{
      logoImageHeightConstraint.constant = 125
    }
  }
}

