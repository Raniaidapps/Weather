//
//  WeatherResponseCompletionInterpreter.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherResponseCompletionInterpreter {
  
  static func fetchWeather(_ response: DataResponse<Any>, _ success: FetchWeatherSuccess?, _ failure: Failure?) {
    
    if let json = response.result.value as? JSON {
      let weatherList = WeatherParser.parsedWeatherItemsFrom(json: json)
      success?(weatherList)
    } else {
      failure?(response.result.error)
    }
  }
}
