//
//  StartButton.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 29/10/20.
//

import UIKit

@objc protocol StartStopButtonProtocol {
    @objc optional func startButtonPressed()
    @objc optional func StopButtonPressed()
}

class StartButton: UIView {
    weak var delegate : StartStopButtonProtocol?
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(startTapped))
        self.addGestureRecognizer(tap)
        
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 5.0
    }
    
    @objc func startTapped() {
        if nameLabel?.text == "Start" {
            self.delegate?.startButtonPressed!()
        } else {
            self.delegate?.StopButtonPressed?()
            NotificationCenter.default.post(name: Notification.Name("stopButton"), object: nil, userInfo: nil)//["Renish":"Dadhaniya"])

        }
    }
  
}
