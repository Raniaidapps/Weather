//
//  Date.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation

extension Date {
  
  static let oneSecond: TimeInterval = 1
  static let oneMinute: TimeInterval = oneSecond*60
  static let oneHour: TimeInterval = oneMinute*60
  static let oneDay: TimeInterval = oneHour*24
  static let oneWeek: TimeInterval = oneDay*7
  
  
  /// Method to convert date to string
   func convertDateToString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "fr_FR")
    
    return dateFormatter.string(from: self)
  }
}
