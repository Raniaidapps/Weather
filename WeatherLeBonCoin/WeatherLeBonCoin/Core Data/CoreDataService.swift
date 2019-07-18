//
//  CoreDataService.swift
//  WeatherLeBonCoin
//
//  Created by RANIA NAJAH on 18/07/2019.
//  Copyright © 2019 RANIA NAJAH. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
  
  // MARK: - Shared
  static let shared = CoreDataService()
  
  var context: NSManagedObjectContext{
    return CoreDataService.shared.persistentContainer.viewContext
  }
  
  /// create and save a weather .
  /// - Parameter date: project String
  /// - Parameter temperature: Double
  /// - Parameter rain: Double
  /// - Parameter wind: Double
  /// - Parameter snow: project date
  
  func addWeather(with date: String,
                  temperature: Double,
                  rain: Double? = nil,
                  wind: Double? = nil,
                  snow: Bool? = false) {
    
    context.perform {
      let weather = WeatherForecast(context: self.context)
      weather.a_date = date
      weather.a_temperature = temperature
      
      if let rain = rain {
        weather.a_rain = rain
      }
      if let wind = wind {
        weather.a_wind = wind
      }
      
      if let isSnowing = snow {
        weather.is_snowing = isSnowing
      }
      self.saveContext()
    }
  }
  
  func retrieveData(_ closure: (Result<[WeatherForecast], Error>) -> Void) {
    //Prepare the request of type NSFetchRequest  for the entity
    let fetchRequest = NSFetchRequest<WeatherForecast>(entityName: "WeatherForecast")
    
    do {
      let result = try context.fetch(fetchRequest)
      closure(.success(result))
    } catch {
      closure(.failure(error))
    }
  }
  
  // MARK: - update/delete
  
  func deleteAllData() {
    
    let fetchRequest = NSFetchRequest<WeatherForecast>(entityName: "WeatherForecast")
    fetchRequest.returnsObjectsAsFaults = false
    do {
      let results = try context.fetch(fetchRequest)
      
      for object in results {
        context.delete(object)
      }
    } catch let error {
      print("Detele all data", error)
    }
  }
  
  func managedObject(with managedObjectId:NSManagedObjectID) -> NSManagedObject?{
    do{
      return try self.context.existingObject(with: managedObjectId)
    }catch(let error){
      print("error retreaving object, error: \(error)")
      return nil
    }
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WeatherDataModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
