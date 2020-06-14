/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController{

  @IBOutlet private weak var view1: DisplayView!
  @IBOutlet private weak var view2: DisplayView!
  @IBOutlet private weak var view3: DisplayView!
  @IBOutlet private weak var headingLabel: UILabel!
  @IBOutlet private weak var themeSwitch: UISwitch!

  private let cryptoData = DataGenerator.shared.generateData()
  private var currentTheme: Theme!

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchCurrentTheme()
    setupViews()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }

  func fetchCurrentTheme() {
    if let savedTheme = ThemeManager.shared.currentTheme {
      currentTheme = savedTheme
    } else {
      currentTheme = LightTheme()
    }
  }

  func setupViews() {
    self.view.backgroundColor = currentTheme.backgroundColor
    
    view1.configure(backgroundColor: currentTheme.widgetBackgroundColor, borderColor: currentTheme.borderColor, textColor: currentTheme.textColor)

    view2.configure(backgroundColor: currentTheme.widgetBackgroundColor, borderColor: currentTheme.borderColor, textColor: currentTheme.textColor)

    view3.configure(backgroundColor: currentTheme.widgetBackgroundColor, borderColor: currentTheme.borderColor, textColor: currentTheme.textColor)
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    headingLabel.textColor = currentTheme.textColor
  }
  
  func setView1Data() {
    guard  let cryptoData = cryptoData else {
      view1.setText(text: "Not data available.")
      return
    }

    let allCryptos = cryptoData.map { $0.name }
      .joined(separator: ", ")
    view1.setText(text: allCryptos)
  }

  
  func setView2Data() {
    guard  let cryptoData = cryptoData else {
      view2.setText(text: "Not data available.")
      return
    }

    let increasingCryptos = cryptoData.filter { $0.currentValue > $0.previousValue }
      .map { $0.name }
      .joined(separator: ", ")
    view2.setText(text: increasingCryptos)
  }
  
  func setView3Data() {
    guard  let cryptoData = cryptoData else {
      view3.setText(text: "Not data available.")
      return
    }

    let decreasingCryptos = cryptoData.filter { $0.currentValue < $0.previousValue }
      .map { $0.name }
      .joined(separator: ", ")
    view3.setText(text: decreasingCryptos)
  }
  
  @IBAction func switchPressed(_ sender: UISwitch) {
    if sender.isOn {
      ThemeManager.shared.set(theme: DarkTheme())
    } else {
      ThemeManager.shared.set(theme: LightTheme())
    }
  }
}




extension HomeViewController: Themeable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name("themeChanged"), object: nil)
  }

  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }

  @objc func themeChanged() {
    fetchCurrentTheme()
    UIView.animate(withDuration: 0.5) {
      self.setupViews()
      self.setupLabels()
    }

  }


}
