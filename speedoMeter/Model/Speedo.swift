//
//  Speedo.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 30/10/20.
//

import Foundation
import UIKit

struct Speedo {
    var timer : String?
    var topSpeed : Double?
    var tripOption: Int?
    var distance: Double?
    var averageSpeed: Double?
    var date: Date?
    
    func getTopSpeed() -> String {
        return "\(topSpeed ?? 0.0) m/s"
    }
    
    func getDistance() -> String {
        if distance! >= 1000.0 {
            let dist = distance! / 1000
            let distRound = dist.rounded(toPlaces: 2)
            return "\(distRound) Km"
        } else {
            return "\(distance ?? 0.0) m"
        }
    }
    
    func getAverageSpeed() -> String {
        return "\(averageSpeed ?? 0.0) m/s"
    }
    
    func getImage() -> UIImage {
        switch tripOption {
        case 0:
            return UIImage(systemName: "bicycle")!
        case 1:
            return UIImage(systemName: "figure.walk")!
        default:
            return UIImage(named: "")!
        }
    }
    
}
