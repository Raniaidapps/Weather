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
  func didFetchWeatherSuccess(_ items: [WeatherForecast]?)
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
  var weatherItems: [WeatherForecast]? {
    didSet {
      tableView.reloadData()
    }
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configurePattern()
    setNavigationBar()
    setupTableView()
    fetchWeatherList()
  }
  
  // MARK: - Set up
  func setNavigationBar() {
    
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
    } else {}
    
    self.navigationController?.navigationBar.topItem?.title = "Météo"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
      UIBarButtonItem.SystemItem.refresh, target: self, action:
      #selector(refrechLocationRequest))
  }
  
  func setupTableView() {
    tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.cellIdentifier)
  }
  
  // TODO: Add method to refresh location ⚠️
  @objc func refrechLocationRequest() { }
  
  // MARK: - Request methods
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
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.cellIdentifier, for: indexPath) as? WeatherTableViewCell,
      let weatherItems = weatherItems else {
        return UITableViewCell()
    }
    
    let currentLastItem = weatherItems[indexPath.row]
    cell.weather = currentLastItem
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let weatherItems = weatherItems else { return 0 }
    return weatherItems.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let weatherItems = weatherItems else { return }
    router?.pushToDetailsViewController(weatherItems[indexPath.row])
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
  
  func didFetchWeatherSuccess(_ items: [WeatherForecast]?) {
    self.weatherItems = items
  }
  
  func didFetchWeatherFailure(_ failure: Error?) {
    print("An error has occured")
  }
}

