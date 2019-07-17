//
//  WeatherAlamofireRouter.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 17/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import Alamofire

private let kRequestTimeout: TimeInterval = 10

private struct paramsKeys {
  static let authKey    = "_auth"
  static let cKey    = "_c"
}

enum WeatherAlamofireRouter: URLRequestConvertible {
  
  static var baseURL =  "https://www.infoclimat.fr/public-api"
  static var authValue = "VE4AFw5wVXdUeVptUCZQeQNrADVaLAEmBHgGZVw5VisAa1Y3UTEDZQNtWidXeAcxByoGZQswVGRXPFEpCnheP1Q%2BAGwOZVUyVDtaP1B%2FUHsDLQBhWnoBJgRhBmNcL1Y3AGBWLFE6A2UDclo5V2YHNwcrBnkLNVRpVzJRNQpkXjpUNQBmDmVVMlQkWidQZVAwAzIANlpnAWgEMQY1XDFWMABnVjNRNwNoA3JaMVdgBzAHMgZlCzxUblc0USkKeF5EVEQAeQ4tVXVUblp%2BUH1QMQNuADQ%3D"
  static var cValue = "07e305e577c1aa99d86d5a7230e15d8b"
  
  case getWeather(Double, Double)
  
  private var method: HTTPMethod {
    switch self {
    case .getWeather:
      return .get
    }
  }
  
  private var urlString: String {
    
    switch self {
      
    case .getWeather(let latitude, let longitude):
      return "\(WeatherAlamofireRouter.baseURL)/gfs/json?_ll=\(latitude),\(longitude)"
    }
  }
  
  private var parameters: [String: Any]? {
    switch self {
      
    case .getWeather(_, _):
      return  [paramsKeys.authKey: WeatherAlamofireRouter.authValue,
               paramsKeys.cKey: WeatherAlamofireRouter.cValue ]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    
    guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
      let URL = Foundation.URL(string: urlString)
      else {
        throw AFError.parameterEncodingFailed(reason: .missingURL)
    }
    
    var request = URLRequest(url: URL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: kRequestTimeout)
    request.httpMethod = method.rawValue
    
    if let parameters = parameters {
      return try URLEncoding.default.encode(request, with: parameters)
    }
    
    return request
  }
}
