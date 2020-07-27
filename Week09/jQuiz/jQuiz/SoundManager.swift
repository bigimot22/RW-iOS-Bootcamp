//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

  static let shared = SoundManager()

  private var player: AVAudioPlayer?

  var isSoundEnabled: Bool {
    get {
      if UserDefaults.standard.object(forKey: "sound") == nil {
        toggleSoundPreference()
      }
      return UserDefaults.standard.bool(forKey: "sound")
    }
  }

  func playSound() {
    print("JD: - playing sounds....")
    player?.stop()

    let path = Bundle.main.path(forResource: "Jeopardy-theme-song.mp3", ofType:nil)!
    let url = URL(fileURLWithPath: path)

    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
    } catch {
      print("Couldnt play sound. Error: \(error)")
    }

  }

  func stopSounds() {
    player?.stop()
  }

  func toggleSoundPreference() {
    let current = UserDefaults.standard.bool(forKey: "sound")
    print("Changin sound prefs from: \(current) to: \(!current)")
    UserDefaults.standard.set(!current, forKey: "sound")
  }

}
