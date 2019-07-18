//
//  WeatherDetailsViewController.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
  
  
  var weather : WeatherItem? {
    didSet {
      guard let weather = weather else { return }
      updateViewDetails()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

  func updateViewDetails() {
    
  }
}
