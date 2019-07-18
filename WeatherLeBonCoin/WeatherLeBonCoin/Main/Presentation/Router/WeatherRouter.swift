//
//  WeatherRouter.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherRouterProtocol {
  func presentPopupLocation()
  func pushToDetailsViewController(_ item: WeatherForecast)
}

class WeatherRouter: WeatherRouterProtocol {
 
  //Reference to the View Controller (weak to avoid retain cycle).
  private(set) weak var viewController: UIViewController?
  
  init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
  /// Present alert to tell the user to activate position
  func presentPopupLocation() {
    let alert = UIAlertController(title: "Pour utiliser la géolocalisation, pensez à l’activer dans Réglages > Général > Services de localisation" , message: nil, preferredStyle: .alert)
    
    alert.addAction(
      UIAlertAction(title: "Annuler", style: .cancel, handler: { _ in
      })
    )
    
    func openSettings() {
      if let settingsUrl = URL(string: UIApplication.openSettingsURLString),
        UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl, options: [:])
      }
    }
    
    alert.addAction(
      UIAlertAction(title: "Réglages", style: .default, handler: { _ in
        openSettings()
      })
    )
    
    viewController?.present(alert, animated: true)
  }
  
  func pushToDetailsViewController(_ item: WeatherForecast) {
    
    let weatherDetailsVC = WeatherDetailsViewController()
    weatherDetailsVC.weather = item
    viewController?.navigationController?.pushViewController(weatherDetailsVC, animated: true)
  }
}
