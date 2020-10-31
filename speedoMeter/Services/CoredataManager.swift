//
//  CoredataManager.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 30/10/20.
//

import Foundation
import UIKit
import CoreData

class CoredataManager {
    
    static let shared = CoredataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addNewTripToLocal(speedo: Speedo) {
        let entity = NSEntityDescription.entity(forEntityName: "Trip", in: context)
        let newTrip = NSManagedObject(entity: entity!, insertInto: context)
        newTrip.setValue(speedo.averageSpeed, forKey: "averageSpeed")
        newTrip.setValue(speedo.timer, forKey: "timer")
        newTrip.setValue(speedo.distance, forKey: "distance")
        newTrip.setValue(speedo.topSpeed, forKey: "topSpeed")
        newTrip.setValue(speedo.tripOption, forKey: "tripOption")
        newTrip.setValue(speedo.date, forKey: "date")
        self.saveData()
    }
    
    func retirveAllTripsFromLocal() -> [Speedo] {
        var tripArray: [Speedo] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let speedo = Speedo(timer: data.value(forKey: "timer") as? String, topSpeed: data.value(forKey: "topSpeed") as? Double, tripOption: data.value(forKey: "tripOption") as? Int, distance: data.value(forKey: "distance") as? Double, averageSpeed: data.value(forKey: "averageSpeed") as? Double, date: data.value(forKey: "date") as? Date)
                tripArray.append(speedo)
            }  
        } catch {
            print("Failed")
        }
        return tripArray
    }
    
    private func saveData() {
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
}
