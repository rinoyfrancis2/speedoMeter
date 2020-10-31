//
//  Util.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 30/10/20.
//

import Foundation
import CoreLocation
import UIKit

class Util {
    
    static func findAverageSpeedWith(_ speedArray: [CLLocationSpeed]) -> Double {
        let sum = speedArray.reduce(0, +)
        return  sum / Double(speedArray.count)
    }
    
    static func findTopSpeedWith(_ speedArray: [CLLocationSpeed]) -> Double {
        return speedArray.max()!
    }
    
    static func findDistanceBetween(initalLocation: CLLocation, destinationLocation: CLLocation) -> Double {
        return initalLocation.distance(from: destinationLocation) / 1000
    }
}

extension Date {
     func changeDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController {
    func presentTo(_ ViewController: OptionViewController, param: Any?) {
        switch ViewController {
        case .DetailViewController:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            if let speedo = param as? Speedo {
                vc.speedoInfo = speedo
            }
            self.present(vc, animated: true, completion: nil)
        case .HistoryViewController:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
}
