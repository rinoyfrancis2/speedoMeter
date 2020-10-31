//
//  DetailViewController.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 29/10/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    @IBOutlet weak var topSpeedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageview: UIImageView!
    var speedoInfo: Speedo?
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImageview.image = speedoInfo?.getImage()
        distanceLabel.text = speedoInfo?.getDistance()
        averageSpeedLabel.text = speedoInfo?.getAverageSpeed()
        topSpeedLabel.text = speedoInfo?.getTopSpeed()
        timeLabel.text = speedoInfo?.timer
        dateLabel.text = speedoInfo?.date?.changeDateFormat()
    }
    deinit {
        speedoInfo = nil
    }
    
    @IBAction func closeVc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
