//
//  WeatherItem.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import UIKit

class WeatherItem: Codable, CustomStringConvertible {
  
  /// Weather date.
  let date: Date
  
  /// Weather temperature value.
  let temperature: Double
  
  /// Weather rain value.
  var rain: Double?
  
  /// Weather wind value.
  var wind: Double?
  
  /// Weather snow value.
  var snow: Bool?
  
  
  init(date: Date, temperature: Double, rain: Double?, wind: Double?, snow: Bool?) {
    self.date = date
    self.temperature = temperature
    self.rain = rain
    self.wind = wind
    self.snow = snow
  }
  
  public var description: String {
    return """
    \(type(of: self)) class
    date: \(date)
    temperature: \(temperature)
    rain: \(String(describing: rain))
    wind: \(String(describing: wind))
    snow: \(String(describing: snow))
    """
  }
}

