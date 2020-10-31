//
//  LocationHandler.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 30/10/20.
//

import CoreLocation
import Foundation
import UserNotifications

protocol LocationHandleProtocol: class {
    func locationHandler(didUpdateWith distance: Double, speed: Double, topSpeed: Double, averageSpeed: Double)
}

class LocationHandler : NSObject {
    private let locationManager = CLLocationManager()
    private var currentLocation : CLLocation?
    private var previousLocation : CLLocation?
    private var speed: CLLocationSpeed?
    private var speedArray: [CLLocationSpeed] = []
    private var distance = 0.0
    weak var delegate : LocationHandleProtocol?
    
    override init() {
        super.init()
        self.initLocationManager()
    }
    
    private func initLocationManager() {
        self.requestLocationPermission()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startUpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdateLocation() {
        locationManager.stopUpdatingLocation()
        speed = nil
        speedArray = []
        distance = 0.0
    }
    
    private func requestLocationPermission() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted, .authorizedWhenInUse:
            break
        default:
            break
        }
    }
}

extension LocationHandler : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
        } else if status == .denied || status == .restricted {
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.previousLocation != nil {
            self.previousLocation = self.currentLocation
        } else {
            self.previousLocation = locations.last
        }
        self.currentLocation = locations.last
        distance = distance + Util.findDistanceBetween(initalLocation: self.previousLocation!, destinationLocation: self.currentLocation!) * 1000
        self.speed = locations.last?.speed
        self.speedArray.append(self.speed!)
        let avgSpeed = Util.findAverageSpeedWith(speedArray).rounded(toPlaces: 2)
        let maxSpeed = Util.findTopSpeedWith(speedArray).rounded(toPlaces: 2)
        self.delegate?.locationHandler(didUpdateWith: distance.rounded(toPlaces: 2), speed: self.speed!.rounded(toPlaces: 2), topSpeed: maxSpeed, averageSpeed: avgSpeed)
    }
}
