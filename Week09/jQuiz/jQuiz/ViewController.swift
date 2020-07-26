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
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!
  
//  var clues: [Clue] = []
//  var correctAnswerClue: Clue?
//  var points: Int = 0
  var userScore = 0 {
    didSet {
      if userScore < 0 { userScore = 0}
      scoreLabel.text = "\(userScore)"
    }
  }

  var viewmodel: QuestionViewModel? = nil {
    didSet {
      DispatchQueue.main.async {
        guard let viewmodel = self.viewmodel else {
          print("JD: - Not viewmodel")
          return }
        self.categoryLabel.text = viewmodel.categoryTitle
        self.clueLabel.text = viewmodel.question
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none

    
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
    
    SoundManager.shared.playSound()
    
    getNextQuestion()
    
  }
  
  private func getNextQuestion() {
    print("JD: - Going to call network...")
    Networking.sharedInstance.getRandomCategory(completion: { (categoryId) in
      guard let id = categoryId else { return }
      Networking.sharedInstance.getAllCluesInCategory(categoryId: id) { clues in
        guard let clues = clues else { return }
        //        self.clues = clues
        self.viewmodel = QuestionViewModel(clues: clues)
        //        self.setUpView()
      }
      
    })
    
  }
  
  private func setUpView() {
//    self.scoreLabel.text = "\(userScore)"
    
  }
  
  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
  }

  private func processUserSelection(selection: String) {
    if selection == viewmodel?.correctAnswer {
      print("Correct answer selected: \(selection)")
      userScore += Int(viewmodel?.points ?? "0") ?? 0
    } else {
      print("Incorrect answer selected: \(selection) - \nCorrect is: \(String(describing: viewmodel?.correctAnswer))")
      userScore -= Int(viewmodel?.points ?? "0") ?? 0
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
    let cell = UITableViewCell()
    if let option = viewmodel?.options[indexPath.row] {
      cell.textLabel?.text = option
      
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let answer = viewmodel?.options[indexPath.row] {
      processUserSelection(selection: answer)
    }
  }
}

