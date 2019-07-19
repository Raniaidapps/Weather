//
//  WeatherWebService.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class  WeatherWebService {
  
  private static var manager: SessionManager = {
    var manager = Alamofire.SessionManager()
    manager.delegate.sessionDidReceiveChallenge = { session, challenge in
      var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
      var credential: URLCredential?
      let protectionSpace = challenge.protectionSpace
      
      if let serverTrust = protectionSpace.serverTrust, protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
        disposition = URLSession.AuthChallengeDisposition.useCredential
        credential = URLCredential(trust: serverTrust)
      } else {
        if challenge.previousFailureCount > 0 {
          disposition = .cancelAuthenticationChallenge
        } else {
          credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: protectionSpace)
          
          if credential != nil {
            disposition = .useCredential
          }
        }
      }
      return (disposition, credential)
    }
    return manager
  }()
  
  // MARK: - Methods
  
  /// Fetch Weather from given location
  /// - Parameters:
  ///   - location: CLLocation -
  ///   - success: FetchWeatherSuccess? - Handler for fetch response success.
  ///   - failure: Failure? - Handler for fetch response failure which gives an Error if occured.
  static func fetchWeatherFrom( _ location: CLLocation,
                                _ success: FetchWeatherSuccess? = nil,
                                _ failure: Failure? = nil ) {
    
    manager.request(
      WeatherAlamofireRouter.getWeather(location.coordinate.latitude, location.coordinate.longitude)
      ).responseJSON { response in
        
        WeatherResponseCompletionInterpreter.fetchWeather(response, success, failure)
    }
  }
}
