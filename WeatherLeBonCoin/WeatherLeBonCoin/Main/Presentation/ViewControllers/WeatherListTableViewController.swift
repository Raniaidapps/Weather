//
//  WeatherListTableViewController.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherViewProtocol: class {
  func didFetchWeatherSuccess(_ items: [WeatherItem]?)
  func didFetchWeatherFailure(_ failure: Error?)
  func locationAuthorizationStatusDidChange()
  func locationAuthorizationDenied()
  func didRequestLocationAuthorization()
}

class WeatherListTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  /// Reference to the Presenter
  var presenter: WeatherPresenter?
  var router: WeatherRouter?
  
  /// Default location
  let location = CLLocation(latitude: 48.85341,
                            longitude: 2.3488)
  
  //Displayed items
  var weatherItems: [WeatherItem]? {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configurePattern()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    fetchWeatherList()
  }
  
  func fetchWeatherList() {
    
    guard let presenter = presenter else {
      return
    }
    
    if presenter.isGeolocEnabled {
      presenter.fetchWeatherFromCurrentLocation()
    } else {
      presenter.fetchWeatherFrom(location)
    }
  }
  
  // MARK: - Private methods
  private func configurePattern() {
    presenter = WeatherPresenter(view: self)
    router = WeatherRouter(viewController: self)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    
    guard let weatherItems = weatherItems else {
      return UITableViewCell()
    }
    
    let currentLastItem = weatherItems[indexPath.row]
    cell.textLabel?.text = currentLastItem.date
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let weatherItems = weatherItems else { return 0 }
    return weatherItems.count
  }
}

extension WeatherListTableViewController: WeatherViewProtocol {
  
  func locationAuthorizationStatusDidChange() {
    fetchWeatherList()
  }
  
  func locationAuthorizationDenied() {
    router?.presentPopupLocation()
  }
  
  func didRequestLocationAuthorization() { }
  
  func didFetchWeatherSuccess(_ items: [WeatherItem]?) {
    self.weatherItems = items
  }
  
  func didFetchWeatherFailure(_ failure: Error?) {
    print("An error has occured")
  }
}

