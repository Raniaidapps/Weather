//
//  WeatherDetailsViewController.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
  
  var weather : WeatherForecast! {
    didSet {
      updateViewDetails()
    }
  }
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [weatherDateLabel, weatherRainLabel, weatherWindLabel])
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let weatherDateLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
    return lbl
  }()
  
  private let weatherRainLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
    return lbl
  }()
  
  private let weatherWindLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
    return lbl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationBarAndView()
    setupLayout()
  }
  
  func updateViewDetails() {
    weatherDateLabel.text = "Date : \(weather.a_date.convertDateToString()))"
    weatherRainLabel.text = "Pluie : \(weather.a_rain)"
    weatherWindLabel.text = "Vents : \(weather.a_wind)"
  }
  
  // MARK: - Set up
  func setNavigationBarAndView() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.topItem?.title = " \(weather.a_temperature) °C"
  }
  
  func setupLayout() {
    
    view.addSubview(stackView)
    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
    
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
}
