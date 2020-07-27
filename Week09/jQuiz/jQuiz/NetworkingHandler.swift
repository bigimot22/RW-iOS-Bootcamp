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

  func getRandomCategory(completion: @escaping (_ categoryId: Int?, _ cluesCount: Int) -> Void) {
    let randomClueEndpoint = "http://www.jservice.io/api/random"
    guard let url = URL(string: randomClueEndpoint) else {
      print("Error: Cannot create URL using - \(randomClueEndpoint)")
      return
    }
    let urlRequest = URLRequest(url: url)
    let session = URLSession.shared

    let task = session.dataTask(with: urlRequest) { data, response, error in
      if error != nil {
        print("Error: \(error!.localizedDescription)")
      }

      if let data = data {
        do {
          let json = try JSONDecoder().decode([Clue].self, from: data)
          let categoryCount = json[0].category.count
          completion(json[0].category.id, categoryCount)
        } catch let error {
          print("Decoding error: \(error) \nData in decoding error: \(String(decoding: data, as: UTF8.self))")
        }
      }
    }
    task.resume()
  }


  func getAllCluesInCategory(categoryId: Int, offset: Int, completion: @escaping ([Clue]?) -> Void) {
    let cluesEndpoint: String = "http://www.jservice.io/api/clues/?category=\(categoryId)&offset=\(offset)"
    guard let url = URL(string: cluesEndpoint) else {
      print("Error: Cannot create URL using - \(cluesEndpoint)")
      return
    }
    let urlRequest = URLRequest(url: url)
    let session = URLSession.shared

    let task = session.dataTask(with: urlRequest) { data, response, error in
      if let response = response {
        print(response.url ?? "response.url is nil.")
      }
      if let error = error {
        print(error)
      }

      if let data = data {
        do {
          let json = try JSONDecoder().decode([Clue].self, from: data)
          let options = Array(json.prefix(4))
          completion(options)

        } catch let error {
          print("Decoding error: \(error)")
        }
      }
    }
    task.resume()
  }

  func getHeaderImage(completion: @escaping (_ data: Data?) -> Void ) {
    let headerImageEndpoint = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
    guard let url = URL(string: headerImageEndpoint) else {
      print("Error: Cannot create URL using - \(headerImageEndpoint)")
      return
    }

    let urlRequest = URLRequest(url: url)
    let session = URLSession.shared

    let task = session.dataTask(with: urlRequest) { data, response, error in
      if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
        print("Image network call status code: \(response.statusCode)")
      }
      if let error = error {
        print(error)
      }

      if let data = data {
        completion(data)
      }
    }
    task.resume()
  }

}
