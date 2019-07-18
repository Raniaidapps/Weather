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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
