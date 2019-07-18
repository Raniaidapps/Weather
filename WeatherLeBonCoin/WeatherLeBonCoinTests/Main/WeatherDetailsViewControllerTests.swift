//
//  WeatherDetailsViewControllerTests.swift
//  WeatherLeBonCoinTests
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import XCTest
@testable import WeatherLeBonCoin

class WeatherDetailsViewControllerTests: XCTestCase {

  func testInitViewController() {
    
    // GIVEN
    let weatherItem = WeatherMock.weatherItem()
    let controller = WeatherDetailsViewController()
    
    // WHEN
    controller.loadViewIfNeeded()
    
    // THEN
  }
  

}
