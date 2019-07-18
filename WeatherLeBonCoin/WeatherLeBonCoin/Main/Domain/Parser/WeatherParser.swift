//
//  WeatherParser.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation

private struct WeatherHeaderKey {
  static let temperature = "temperature"
  static let ground = "sol"
  static let rain = "pluie"
  static let wind = "vent_moyen"
  static let windElement = "10m"
  static let snow = "risque_neige"
}

class WeatherParser {
  
  static func parsedWeatherItemsFrom(json: JSON ) -> [WeatherItem] {
    var weatherItems = [WeatherItem]()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd HH:mm:ss" // Date format
    
    for key:String in json.keys {
      
      guard let weatherDict = json[key] as? JSON else {
        continue
      }
      
      let date = formatter.date(from: key)
      
      if let date = date,
        (date.timeIntervalSinceNow.sign == .plus) {
        weatherItems.appendIfNotNil(parsedWeatherItemFrom(json: weatherDict, date: date))
        
      }
    }
    return weatherItems
  }
  
  private static func parsedWeatherItemFrom(json: JSON, date: Date) -> WeatherItem? {
    
    guard let temperature = json[WeatherHeaderKey.temperature] as? JSON,
      let ground = temperature[WeatherHeaderKey.ground] as? Double,
      let rain = json[WeatherHeaderKey.rain] as? Double,
      
      let windHeader = json[WeatherHeaderKey.wind] as? JSON,
      let wind = windHeader[WeatherHeaderKey.windElement] as? Double,
      
      let snow = json[WeatherHeaderKey.snow] as? String
      
      else {
        return nil
    }
    
    return WeatherItem(date: date,
                       temperature: convertTemperature(ground),
                       rain: rain,
                       wind: wind,
                       snow: (snow == "non") ? false : true) // Convert text to Bool
  }
  
  // MARK: -  Conversion Methods
  
  /// Method to convert temperature from Kelvin to celsius
  private static func convertTemperature(_ degrees: Double) -> Double {
    return (degrees - 273.15).rounded()
  }
}
