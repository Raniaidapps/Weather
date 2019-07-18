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
  
  static let authValue    = "CRMFEg9xBiRSf1BnAnQCKwVtBDEOeAUiVCgLaAFkVShWPVIzAmJdO1E/VyoEKwo8Un8HZA41U2MCaQd/C3kHZgljBWkPZAZhUj1QNQItAikFKwRlDi4FIlQ+C2wBclU/VjRSKAJgXTxROlcrBDUKOFJpB3gOLlNqAmQHYQtuB2YJbAVhD2UGbFI1UC0CLQIzBWcEYw5kBWlUNQs6AT9VMlZhUjUCZl09UT5XKwQxCjtSZgdnDjVTaQJpB2MLeQd7CRMFEg9xBiRSf1BnAnQCKwVjBDoOZQ=="
  
  static let cValue    = "f689bce901f5c8bf87c8b9c6699b7332"
  
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
