//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {

  static let sharedInstance = Networking()
  private init(){}

  //TODO: Get a random category​. Make a GET request to h​ttp://www.jservice.io/api/random
  func fetch() {
    guard let url = URL(string: "http://www.jservice.io/api/random") else {
      print("JD: - Incorrect URL.")
      return }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if error != nil {
        print("Error: \(error!.localizedDescription)")
      }
      if let data = data {
        print("Got network data: \(data)")
      }
    }
    .resume()

    print("JD: - Finnish calling network.")
  }


}
