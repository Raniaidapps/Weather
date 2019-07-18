//
//  OHHTTPStubsUtil.swift
//  WeatherLeBonCoinTests
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import OHHTTPStubs
import XCTest

extension XCTestCase {
  
  func setupStubGetWithError() {
    stub(condition: isMethodGET()) { _ in
      return OHHTTPStubsResponse(error: NSError(domain: "error", code: 400, userInfo: nil))
    }
  }
  
  func setupStubPostWithError() {
    stub(condition: isMethodPOST()) { _ in
      return OHHTTPStubsResponse(error: NSError(domain: "error", code: 400, userInfo: nil))
    }
  }
  
  func setupStubPutWithError() {
    stub(condition: isMethodPUT()) { _ in
      return OHHTTPStubsResponse(error: NSError(domain: "error", code: 400, userInfo: nil))
    }
  }
  
  func setupStubDeletetWithError() {
    stub(condition: isMethodDELETE()) { _ in
      return OHHTTPStubsResponse(error: NSError(domain: "error", code: 400, userInfo: nil))
    }
  }
  
  func setupStubGet(_ filename: String, status: Int32 = 200) {
    stub(condition: isMethodGET()) { _ in
      let stubPath = OHPathForFile(filename, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
  }
  
  func setupStubGetAndUrlContains(urlContains: String, _ filename: String, status: Int32 = 200) {
    stub(condition: {
      rqt in return rqt.url!.absoluteString.contains(urlContains)
    }) { _ in
      let stubPath = OHPathForFile(filename, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
  }
  
  func setupStubPostUrlEncoded(_ filename: String, status: Int32) {
    stub(condition: isMethodPOST()) { _ in
      let stubPath = OHPathForFile(filename, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/x-www-form-urlencoded"])
    }
  }
  
  func setupStubPostJSON(_ filename: String, status: Int32 = 200) {
    stub(condition: isMethodPOST()) { _ in
      let stubPath = OHPathForFile(filename, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
  }
  
  func setupStubDeleteJSON(_ filename: String, status: Int32 = 200) {
    stub(condition: isMethodDELETE()) { _ in
      let stubPath = OHPathForFile(filename, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
  }
  
  func setupStubPost(status: Int32 = 200) {
    stub(condition: isMethodPOST()) { _ in
      return OHHTTPStubsResponse(data: Data.init(), statusCode: status, headers: nil)
    }
  }
  
  func setupStubPut(_ filename: String, status: Int32 = 200) {
    stub(condition: isMethodPUT()) { _ in
      let stubPath = OHPathForFile(filename, type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }
  }
  
  func setupStubDelete(status: Int32 = 200) {
    stub(condition: isMethodDELETE()) { _ in
      return OHHTTPStubsResponse(data: Data(), statusCode: status, headers: nil)
    }
  }
}
