//
//  WeatherManager.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

struct WeatherManager {
  
  // Fetch Departments validity cache time
  private static let weatherCacheValidityTime: TimeInterval = Date.oneHour
  
  // MARK: - Web Services
  
  /// Get the weather list for given location
  ///
  /// - Parameters:
  ///   - text: String -
  ///   - success: FetchWeatherSuccess? - Handler for fetch response success.
  ///   - failure: Failure? - Handler for fetch response failure which gives an Error if occured.
  
  static func getWeatherFrom(location: CLLocation,
                             succes: FetchWeatherSuccess? = nil,
                             failure: Failure? = nil) {
    
   
    WeatherWebService.fetchWeatherFrom(location, succes, failure)
  }
  
  static func clearWeatherCache() {
    CoreDataService.shared.deleteAllData()
  }
  
  static func saveWeatherInCache(with items: [WeatherItem]) {
    
    clearWeatherCache()
    
    for item in items {
      CoreDataService.shared.addWeather(with: item.date,
                                        temperature: item.temperature,
                                        rain: item.rain,
                                        wind: item.wind,
                                        snow: item.snow)
    }
  }
  
}
