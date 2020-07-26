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
  var viewmodel: QuestionViewModel? = nil {
    didSet {
      DispatchQueue.main.async {
        guard let viewmodel = self.viewmodel else {
          print("JD: - Not viewmodel")
          return }
        self.categoryLabel.text = viewmodel.categoryTitle
        self.clueLabel.text = viewmodel.question
        self.scoreLabel.text = viewmodel.points
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
    
    getQuestion()
    
  }
  
  private func getQuestion() {
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
//    self.scoreLabel.text = "\(self.points)"
    
  }
  
  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
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
    
  }
}

