//
//  WeatherForecast+CoreDataProperties.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecast> {
        return NSFetchRequest<WeatherForecast>(entityName: "WeatherForecast")
    }

    @NSManaged public var a_date: String
    @NSManaged public var a_rain: Double
    @NSManaged public var a_temperature: Double
    @NSManaged public var a_wind: Double
    @NSManaged public var is_snowing: Bool

}
