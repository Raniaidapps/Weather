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
  
  // MARK: - DAO
  
  /// Clear the cache from DB
  static func clearCurrentWeatherCache() {
    CoreDataService.shared.deleteAllData()
  }
  
  /// Get the weather from WS and save it in DB
  static func saveWeatherInCache(with items: [WeatherItem]) {
    
    clearCurrentWeatherCache()
    CoreDataService.shared.getAndSaveWeatherFromWS(items)
  }
  
  static func retrieveData(_ closure: @escaping ([WeatherForecast]) -> Void) {
    CoreDataService.shared.retrieveData(closure)
  }
}
