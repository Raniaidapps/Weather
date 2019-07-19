//
//  WeatherWebServiceTests.swift
//  WeatherLeBonCoinTests
//
//  Created by RANIA NAJAH on 19/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import XCTest
@testable import WeatherLeBonCoin
import CoreData
import OHHTTPStubs
import CoreLocation

class WeatherWebServiceTests: XCTestCase {
  
  let location = CLLocation(latitude: 48.85341,
                            longitude: 2.3488)
    // MARK: - Setup
    override func setUp() {
      super.setUp()
      OHHTTPStubs.removeAllStubs()
    }
    
    override func tearDown() {
      OHHTTPStubs.removeAllStubs()
      super.tearDown()
    }
    
    // MARK: Test
    func testFetchWeatherSuccess() {
      // GIVEN
      setupStubGet("WeatherMock.json", status: 200)
      
      let expectation = self.expectation(description: "request completion")
      
      // WHEN
      WeatherManager.getWeatherFrom(location: location, succes: { (weatherItems) in
        // THEN
        XCTAssertNotNil(weatherItems)
        expectation.fulfill()
      }, failure: nil)
      waitForExpectations(timeout: 2, handler: nil)
  }
  
  func testFetchWeatherFailure() {
    setupStubGetWithError()
    
    let expectation = self.expectation(description: "request completion")
    
    WeatherManager.getWeatherFrom(location: location, failure: { _ in
      expectation.fulfill()
    })
    
    waitForExpectations(timeout: 2, handler: nil)
  }
}
