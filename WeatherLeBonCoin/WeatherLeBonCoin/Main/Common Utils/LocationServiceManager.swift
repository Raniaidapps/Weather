//
//  LocationServiceManager.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 19/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let LocationAuthorizationStatusChangedNotification = "LocationAuthorizationStatusChangedNotification"

class LocationServiceManager: NSObject, CLLocationManagerDelegate {
  
  // MARK: - Properties
  
  static let shared = LocationServiceManager()
  
  let locationManager = CLLocationManager()
  
  private var completionBlock: ((_ location: CLLocation?, _ error: Error?) -> Void)?
  var currentLocation: CLLocation?
  
  var authorizationStatus: CLAuthorizationStatus {
    return CLLocationManager.authorizationStatus()
  }
  
  var isServiceAvailable: Bool {
    return CLLocationManager.locationServicesEnabled() && ( authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse )
  }
  
  private override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }
  
  // MARK: - Methods
  
  func requestAuthorization() {
    if authorizationStatus == .notDetermined {
      locationManager.requestAlwaysAuthorization()
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func getCurrentLocation(_ completion: @escaping (_ location: CLLocation?, _ error: Error?) -> Void) {
    self.completionBlock = completion
    if let currentLocation = currentLocation {
      completionBlock?(currentLocation, nil)
    } else {
      startUpdatingLocation()
    }
  }
  
  func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
  }
  
  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
    self.completionBlock = nil
  }
  
  // MARK: - CLLocationManagerDelegate
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    currentLocation = locations.last
    completionBlock?(locations.last, nil)
    stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    completionBlock?(nil, error)
    stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    NotificationCenter.default.post(name: Notification.Name(rawValue: LocationAuthorizationStatusChangedNotification), object: nil)
  }
}
