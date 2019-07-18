//
//  WeatherTableViewCell.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
  
  static let cellIdentifier = "WeatherTableViewCell"
  
  var weather : WeatherForecast? {
    didSet {
      guard let weather = weather else { return }
      weatherDateLabel.text = convertDateToString(weather.a_date)
      weatherTemperatureLabel.text = String(weather.a_temperature) + " °C"
    }
  }
  
  private let weatherDateLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.textAlignment = .left
    return lbl
  }()
  
  private let weatherTemperatureLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(weatherDateLabel)
    addSubview(weatherTemperatureLabel)
    
    weatherDateLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 16, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
    
    weatherTemperatureLabel.anchor(top: weatherDateLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Method to convert date to string
  private func convertDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "fr_FR")
    
    return dateFormatter.string(from: date)
  }
}
