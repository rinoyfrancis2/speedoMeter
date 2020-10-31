//
//  SpeedoViewController.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 29/10/20.
//

import UIKit

class SpeedoViewController: UIViewController {

    @IBOutlet weak var travelOptionButtonView: ButtonView!
    @IBOutlet weak var startButtonView: StartButton!
    @IBOutlet weak var travelTipLabel: UILabel!
    @IBOutlet weak var traveltripView: TripView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        travelOptionButtonView.delegate = self
        startButtonView.delegate = self
        traveltripView.delegate = self
        startButtonView.hide()
        travelTipLabel.show()
        traveltripView.hide()
    }
    
    func presentDetail(speedo : Speedo) {
        self.presentTo(OptionViewController.DetailViewController, param: speedo)
    }
    
    @IBAction func historyActionButton(_ sender: Any) {
        self.presentTo(OptionViewController.HistoryViewController, param: "")
    }
}

extension SpeedoViewController : BottomButtonsViewProtocol {
    func cycleButtonPressed() {
        travelOptionButtonView.joggerButtonHide()
        startButtonView.show()
        travelTipLabel.hide()
        traveltripView.tripOption = TripOption.cycle
    }
    
    func joggerButtonPressed() {
        travelOptionButtonView.cycleButtonHide()
        startButtonView.show()
        travelTipLabel.hide()
        traveltripView.tripOption = TripOption.jogger
    }
}

extension SpeedoViewController : StartStopButtonProtocol {
    func startButtonPressed() {
        travelOptionButtonView.hide()
        startButtonView.hide()
        traveltripView.show()
        traveltripView.startTrip()
    }
}

extension SpeedoViewController : TripViewProtocol {
    func tripStopButtonPressedWith(speedo: Speedo) {
        traveltripView.hide()
        startButtonView.hide()
        travelTipLabel.show()
        travelOptionButtonView.show()
        travelOptionButtonView.showAllRideOptions()
        CoredataManager.shared.addNewTripToLocal(speedo: speedo)
        self.presentDetail(speedo: speedo)
    }
    
    func tripStarted() {
        
    }
}
