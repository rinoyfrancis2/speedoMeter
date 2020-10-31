//
//  TripView.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 29/10/20.
//

import UIKit

protocol TripViewProtocol: class {
    func tripStopButtonPressedWith(speedo: Speedo)
    func tripStarted()
}

class TripView: UIView {

    weak var delegate : TripViewProtocol?
    @IBOutlet weak var timerLabel: UILabel?
    @IBOutlet weak var speedLabel: UILabel?
    @IBOutlet weak var DistanceLabel: UILabel?
    @IBOutlet weak var averageSpeedLabel: UILabel?
    @IBOutlet weak var stopButtonView: StartButton?
    private let locationHandler = LocationHandler()
    private var timer = Timer()
    private var totalSecond = Int()
    private var topSpeed : String?
    private var speedo : Speedo?
    var tripOption : TripOption?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        locationHandler.delegate = self
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter(timer:)), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        totalSecond = 0
        timerLabel?.text = "00:00:00"
        speedLabel?.text = "0.0 m/s"
        DistanceLabel?.text = "0.0 m"
        averageSpeedLabel?.text = "0.0 m/s"
    }
    
    @objc func updateCounter(timer: Timer) {
        var hours: Int = 0
        var minutes: Int = 0
        var seconds: Int = 0
        totalSecond = totalSecond - 1
        hours = totalSecond / 3600
        minutes = (totalSecond % 3600) / 60
        seconds = (totalSecond % 3600) % 60
        timerLabel!.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds).replacingOccurrences(of: "-", with: "")
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        self.stopTimer()
        locationHandler.stopUpdateLocation()
        NotificationCenter.default.removeObserver(self, name: Notification.Name("stopButton"), object: nil)
        let currentDate = Date()
        speedo?.date = currentDate//
        self.delegate?.tripStopButtonPressedWith(speedo: speedo!)
    }
    
    func startTrip() {
        self.startTimer()
        locationHandler.startUpdateLocation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("stopButton"), object: nil)
        self.delegate?.tripStarted()
   }
}

extension TripView : LocationHandleProtocol {
    func locationHandler(didUpdateWith distance: Double, speed: Double, topSpeed: Double, averageSpeed: Double) {
        self.DistanceLabel!.text = "\(distance) m"
        self.averageSpeedLabel!.text = "\(averageSpeed) m/s"
        self.speedLabel!.text = "\(speed) m/s"
        self.topSpeed = "\(topSpeed) m/s"
        speedo = Speedo()
        speedo?.tripOption = tripOption?.rawValue
        speedo?.averageSpeed = averageSpeed
        speedo?.distance = distance
        speedo?.timer = timerLabel?.text
        speedo?.topSpeed = topSpeed
    }
}

