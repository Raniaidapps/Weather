//
//  WeatherPresenter.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherPresenterPresenterProtocol: class {
  var isGeolocEnabled: Bool { get }
  var geolocAuthorizationStatus: CLAuthorizationStatus { get }
  func requestAuthorization()
  func fetchWeatherFrom(_ location: CLLocation?)
  func fetchWeatherFromCurrentLocation()
}

class WeatherPresenter: WeatherPresenterPresenterProtocol {
  
  //Reference to the View (weak to avoid retain cycle).
  private(set) weak var view: WeatherViewProtocol?
  var isGeolocEnabled: Bool {
    return LocationServiceManager.shared.isServiceAvailable
  }
  
  var geolocAuthorizationStatus: CLAuthorizationStatus {
    return LocationServiceManager.shared.authorizationStatus
  }
  
  init(view: WeatherViewProtocol) {
    self.view = view
  }
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func requestAuthorization() {
    NotificationCenter.default.addObserver(self, selector: #selector(locationAuthorizationStatusDidChange),
                                           name: NSNotification.Name(rawValue: LocationAuthorizationStatusChangedNotification),
                                           object: nil)
    
    LocationServiceManager.shared.requestAuthorization()
    
    view?.didRequestLocationAuthorization()
  }
  
  /// Fetch Weather from given location
  func fetchWeatherFrom(_ location: CLLocation?) {
    
    guard let location = location else { return }
    
    WeatherManager.getWeatherFrom(location: location, succes: { (weather) in
      WeatherManager.saveWeatherInCache(with: weather)
      
      WeatherManager.retrieveData{ [weak self] forecasts in
        self?.view?.didFetchWeatherSuccess(forecasts)
        
      }
    }) { (error) in
      self.view?.didFetchWeatherFailure(error)
    }
  }
  
  /// If geolocation is enabled, fetch weather from current location
  func fetchWeatherFromCurrentLocation() {
    if requestLocationAuthorization() {
      return
    }
    LocationServiceManager.shared.getCurrentLocation { [weak self] (location, error) in
      
      if let location = location {
        self?.fetchWeatherFrom(location)
      } else {
        self?.view?.didFetchWeatherFailure(error)
      }
    }
  }
  
  @objc func locationAuthorizationStatusDidChange() {
    view?.locationAuthorizationStatusDidChange()
  }
  
  /// Check if location authorization is enabled
  func requestLocationAuthorization() -> Bool {
    
    if geolocAuthorizationStatus == .notDetermined {
      requestAuthorization()
      return true
      
    } else if geolocAuthorizationStatus == .denied {
      view?.locationAuthorizationDenied()
      return true
    }
    return false
  }
}
