//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct QuestionViewModel {
  let categoryTitle: String
  let question: String
  let correctAnswer: String
  let options: [String]
  let points: String

  init(clues: [Clue]) {
    let firstClue = clues.first
    categoryTitle = firstClue?.category.title ?? "Category"
    question = firstClue?.question ?? "Question"
    correctAnswer = firstClue?.answer ?? "Answer"
    points = String(firstClue?.value ?? 10)
    var opts = [String]()
    for clue in clues {
      opts.append(clue.answer)
    }
    options = opts.shuffled()
  }
}

class Networking {
  static let sharedInstance = Networking()
  private init(){}

  func getRandomCategory(completion: @escaping (Int?) -> Void) {
    let randomClueEndpoint = "http://www.jservice.io/api/random"
    guard let url = URL(string: randomClueEndpoint) else {
      print("Error: Cannot create URL using - \(randomClueEndpoint)")
      return }
    let urlRequest = URLRequest(url: url)
    let session = URLSession.shared
    let task = session.dataTask(with: urlRequest) { data, response, error in
      if error != nil {
        print("Error: \(error!.localizedDescription)")
      }
      if let data = data {
        print("Got network data: \(data)")
        do {
          let json = try JSONDecoder().decode([Clue].self, from: data)
          //          print("\(json)")
          print("Got category: \(json[0].category.id)")
          completion(json[0].category.id)

        } catch let error {
          print("Decoding error: \(error) \nData in decoding error: \(String(decoding: data, as: UTF8.self))")
        }
      }
    }
    task.resume()
    print("JD: - Finnish calling network.")
  }


  func getAllCluesInCategory(categoryId: Int, completion: @escaping ([Clue]?) -> Void) {
    //http://www.jservice.io/api/clues/?category=11547​.
    let cluesEndpoint: String = "http://www.jservice.io/api/clues/?category=\(categoryId)"
    guard let url = URL(string: cluesEndpoint) else {
      print("Error: Cannot create URL using - \(cluesEndpoint)")
      return
    }
    let urlRequest = URLRequest(url: url)
    let session = URLSession.shared
    let task = session.dataTask(with: urlRequest) { data, response, error in
      if let response = response {
        print(response.url ?? "url")
      }
      if let error = error {
        print(error)
      }

      if let data = data {
        print("Got network data: \(data)")
        do {
          let json = try JSONDecoder().decode([Clue].self, from: data)
          //          print("\(json)")
          print("\(json[0].category.id)")
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
      if let response = response {
        print(response.url ?? "url")
      }
      if let error = error {
        print(error)
      }

      if let data = data {
        print("Got network data: \(data)")
        completion(data)
      }
    }
    task.resume()



  }


}
