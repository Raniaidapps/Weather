//
//  Array.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 19/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation

extension Array {
  
  /// Adds an element to the end of the collection if not nil.
  ///
  /// - Parameter newElement optional: The element to append to the collection.
  /// - Returns: true if the new element was successfully added to the collection, false if the new element was nil
  
  @discardableResult
  mutating func appendIfNotNil(_ newElement: Element?) -> Bool {
    guard let e = newElement else { return false }
    append(e)
    return true
  }
}
