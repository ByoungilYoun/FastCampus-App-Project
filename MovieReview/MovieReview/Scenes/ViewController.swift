//
//  ViewController.swift
//  MovieReview
//
//  Created by 윤병일 on 2022/03/08.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    MovieSearchManager().request(from: "StarWars") { movies in
      print(movies)
    }
  }
  
}
